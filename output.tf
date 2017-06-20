output "delivery_role_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "delivery_queue_arn" {
  value = "${aws_sqs_queue.queue.arn}"
}

output "private_key" {
  value = "${tls_private_key.key.private_key_pem}"
}

output "public_key" {
  value = "${tls_private_key.key.public_key_pem}"
}