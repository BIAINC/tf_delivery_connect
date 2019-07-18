# Policy for IAM Role

resource "aws_iam_user" "agent" {
  name = "td_delivery_agent"
  path = "/${var.aws_path}/"
}

resource "aws_iam_access_key" "agent" {
  user = aws_iam_user.agent.name
}

resource "aws_iam_role" "agent_role" {
  name               = "td_delivery_agent"
  assume_role_policy = data.aws_iam_policy_document.agent_assume_role.json
}

resource "aws_iam_policy" "agent_policy" {
  name        = "td_agent_policy"
  path        = "/${var.aws_path}/"
  description = "TotalDiscovery Delivery Agent Policy"

  policy = data.aws_iam_policy_document.agent_delivery_policy.json
}

resource "aws_iam_policy_attachment" "agent" {
  name       = aws_iam_policy.agent_policy.name
  roles      = [aws_iam_role.agent_role.name]
  policy_arn = aws_iam_policy.agent_policy.arn
}

