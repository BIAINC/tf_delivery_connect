// Baisc role policy that allows the TD root account to 
// impersonate the given role.
data "aws_iam_policy_document" "connector_assume_role" {
  statement {
    sid     = "TrustedAccountImpersonation"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.trusted_root_account}:root"]
    }
  }
}

// Setup the role policy to allow access to the minimal set of
// items that are required to perform delivery
data "aws_iam_policy_document" "connector_delivery_policy" {
  statement {
    sid     = "AllowBucketCreation"
    actions = ["s3:CreateBucket"]

    condition {
      test     = "StringLike"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }

    resources = [
      "arn:aws:s3:::delivery-*",
    ]
  }

  statement {
    sid     = "UploadDataToDelieryBuckets"
    actions = ["s3:PutObject"]

    condition {
      test     = "StringLike"
      variable = "s3:x-amz-server-side-encryption"

      values = [
        "AES256",
      ]
    }

    resources = [
      "arn:aws:s3:::delivery-*",
    ]
  }

  statement {
    sid = "SetupBucketNotifications"

    actions = [
      "s3:PutBucketNotification",
      "s3:GetBucketNotification",
    ]

    resources = [
      "arn:aws:s3:::delivery-*",
    ]
  }

  statement {
    sid = "ReadSmartID"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::delivery-*/smart_id.json",
    ]
  }

  statement {
    sid = "ListDeliveryBucketContents"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::delivery-*",
    ]
  }

  statement {
    sid = "ListAllBuckets"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }
}

// Setup the policy that allows S3 to post items to the delivery queue
data "aws_iam_policy_document" "connector_s3_sqs" {
  statement {
    sid       = "AllowS3toDeliverySQS"
    actions   = ["SQS:SendMessage"]
    resources = [aws_sqs_queue.queue.arn]
    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        "arn:aws:s3:::delivery-*",
      ]
    }

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}

