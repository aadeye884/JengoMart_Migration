variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  default = "jengomart"
}
variable "az1" {
  default = "us-east-1a"
}
variable "pubsn1_cidr" {
  default = "10.0.1.0/24"
}
variable "pubsn1" {
  default = "pubsn1"
}
variable "pubsn2_cidr" {
  default = "10.0.2.0/24"
}
variable "az2" {
  default = "us-east-1b"
}
variable "pubsn2" {
  default = "pubsn2"
}
variable "igw_name" {
  default = "jengomart_igw"
}
variable "pubsnrt" {
  default = "jengomart_pubsnrt"
}
variable "ngw_name" {
  default = "jengomart_ngw"
}
variable "prvsnrt" {
  default = "jengomart_prvsnrt"
}
variable "prvsn1_cidr" {
  default = "10.0.3.0/24"
}
variable "prvsn1" {
  default = "prvsn1"
}
variable "prvsn2_cidr" {
  default = "10.0.4.0/24"
}
variable "prvsn2" {
  default = "prvsn2"
}
variable "all" {
  default = "0.0.0.0/0"
}