// Allow the delivery agent to assume this role
data "aws_iam_policy_document" "agent_assume_role" {
  statement {
    sid     = "TrustedAccountImpersonation"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.agent.arn]
    }
  }
}

// Setup the role policy to allow access to the minimal set of
// items that are required to perform delivery
data "aws_iam_policy_document" "agent_delivery_policy" {
  statement {
    sid = "ManageDeliveryBuckets"

    actions = [
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::delivery-*",
    ]
  }

  statement {
    sid = "DeliverySQS"

    actions = [
      "SQS:ChangeMessageVisibility",
      "SQS:ChangeMessageVisibilityBatch",
      "SQS:DeleteMessage",
      "SQS:DeleteMessageBatch",
      "SQS:GetQueueAttributes",
      "SQS:GetQueueUrl",
      "SQS:ReceiveMessage",
      "SQS:SendMessage",
      "SQS:SendMessageBatch",
    ]

    resources = [
      aws_sqs_queue.queue.arn,
    ]
  }
}

