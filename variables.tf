variable "trusted_root_account" {
  type        = string
  description = "The root account to trust"
  default     = "832478607820"
}

provider "aws" {
  region = "us-east-1"
}

variable "visibility_timeout" {
  type    = string
  default = 30
}

variable "message_retention_seconds" {
  type    = string
  default = 1209600
}

variable "max_message_size" {
  type    = string
  default = 262144
}

variable "config_dir" {
  type    = string
  default = "~/.td"
}

variable "aws_path" {
  type    = string
  default = "td"
}

