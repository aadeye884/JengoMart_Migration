variable "bucket_name" {
  default = "newproject"
}
variable "acl" {
  default = "private"
}
variable "region" {
  default = "us-east-1"
}
variable "table_name" {
  default = "newproject_tf-state-lock"
}
variable "key_name" {
  default = ""
}