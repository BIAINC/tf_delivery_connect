output "delivery_role_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "delivery_queue_arn" {
  value = "${aws_sqs_queue.queue.arn}"
}
