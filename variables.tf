variable "trusted_root_account" {
  type = "string"
  description = "The root account to trust"
  default = "832478607820"
}

variable "aws_access_key" {
  type = "string"
  description = "Your AWS access key"
}

variable "aws_secret_key" {
  type = "string"
  description = "Your AWS secret access key"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}