variable "instance_type" {}

variable "ami" {}

variable "subnet_id" {}

variable "availability_zone" {}

variable "key_name" {}

variable "vpc_security_group_ids" {}

variable "iam_instance_profile" {}

variable "discovery" {
  default = "~/script/discovery.txt"
}

variable "playbook" {
  default = "~/script/playbook.txt"
}

variable "key" {
  default = "~/Keypairs/jengomartkeypair"
}