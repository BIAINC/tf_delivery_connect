output "connector_role_arn" {
  value = aws_iam_role.connector_role.arn
}

output "delivery_queue_arn" {
  value = aws_sqs_queue.queue.arn
}

