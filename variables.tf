variable "trusted_root_account" {
  type        = "string"
  description = "The root account to trust"
  default     = "832478607820"
}

variable "aws_access_key" {
  type        = "string"
  description = "Your AWS access key"
}

variable "aws_secret_key" {
  type        = "string"
  description = "Your AWS secret access key"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}

variable "visibility_timeout" {
  type    = "string"
  default = 30
}

variable "message_retention_seconds" {
  type    = "string"
  default = 1209600
}

variable "max_message_size" {
  type    = "string"
  default = 262144
}

variable "queue_name" {
  type    = "string"
  default = "totaldiscovery_delivery_connect"
}

variable "role_name" {
  type    = "string"
  default = "totaldiscovery_delivery_connect"
}

variable "policy_name" {
  type    = "string"
  default = "totaldiscovery_delivery_connect"
}
