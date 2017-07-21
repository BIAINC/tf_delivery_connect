resource "aws_iam_role" "role" {
  name = "${var.role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.trusted_root_account}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "${var.policy_name}"
  path        = "/"
  description = "TotalDiscovery Delivery Connect Policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "BucketCreation",
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket"
            ],
            "Condition": {
                "StringLike": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            },
            "Resource": [
                "arn:aws:s3:::delivery-*"
            ]
        },
        {
            "Sid": "BucketNotifications",
            "Effect": "Allow",
            "Action": [
                "s3:PutBucketNotification",
                "s3:GetBucketNotification"
            ],
            "Resource": [
                "arn:aws:s3:::delivery-*"
            ]
        },
        {
            "Sid": "BucketUploads",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::delivery-*/*"
            ],
            "Condition": {
                "StringLike": {
                    "s3:x-amz-server-side-encryption": "AES256"
                }
            }
        },
        {
            "Sid": "ReadSmartID",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::delivery-*/smart_id.json"
            ]
        },
        {
            "Sid": "BucketListing",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::delivery-*"
            ],
            "Condition": {}
        },
        {
            "Sid": "ShowBuckets",
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*",
            "Condition": {}
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "${aws_iam_policy.policy.name}"
  roles      = ["${aws_iam_role.role.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_sqs_queue" "queue" {
  name                       = "${var.queue_name}"
  max_message_size           = "${var.max_message_size}"
  message_retention_seconds  = "${var.message_retention_seconds}"
  visibility_timeout_seconds = "${var.visibility_timeout}"
}

resource "aws_sqs_queue_policy" "queue" {
  queue_url = "${aws_sqs_queue.queue.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": {
        "Service": [
            "s3.amazonaws.com"
        ]
      },
      "Action": "SQS:SendMessage",
      "Resource": "${aws_sqs_queue.queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws:s3:::delivery-*"
        }
      }
    }
  ]
}
POLICY
}