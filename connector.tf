resource "aws_iam_role" "connector_role" {
  name               = "td_delivery_connector"
  assume_role_policy = data.aws_iam_policy_document.connector_assume_role.json
}

resource "aws_iam_policy" "connector_policy" {
  name        = "td_delivery_connector"
  path        = "/${var.aws_path}/"
  description = "TotalDiscovery Delivery Connect Policy"

  policy = data.aws_iam_policy_document.connector_delivery_policy.json
}

resource "aws_iam_policy_attachment" "connector_attach" {
  name       = aws_iam_policy.connector_policy.name
  roles      = [aws_iam_role.connector_role.name]
  policy_arn = aws_iam_policy.connector_policy.arn
}

resource "aws_sqs_queue" "queue" {
  name                       = "td_delivery_queue"
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout
}

resource "aws_sqs_queue_policy" "queue" {
  queue_url = aws_sqs_queue.queue.id

  policy = data.aws_iam_policy_document.connector_s3_sqs.json
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

