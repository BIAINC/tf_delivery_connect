data "aws_sqs_queue" "queue" {
  name = aws_sqs_queue.queue.name
}

data "template_file" "config" {
  template = file("${path.module}/templates/config.toml")

  vars = {
    sqs_arn           = data.aws_sqs_queue.queue.url
    access_key_id     = aws_iam_access_key.agent.id
    secret_access_key = aws_iam_access_key.agent.secret
    role              = aws_iam_role.agent_role.arn
    private_key       = "${var.config_dir}/priv.key"
  }
}

resource "local_file" "config" {
  content  = data.template_file.config.rendered
  filename = "${pathexpand(var.config_dir)}/config.toml"
}

resource "local_file" "private" {
  content  = tls_private_key.key.private_key_pem
  filename = "${pathexpand(var.config_dir)}/priv.key"
}

resource "local_file" "public" {
  content  = tls_private_key.key.public_key_pem
  filename = "${pathexpand(var.config_dir)}/pub.key"
}

