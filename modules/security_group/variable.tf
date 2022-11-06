variable "vpc_id" {
  default = ""
}

variable "sg_name1" {
  default = ""
}
variable "sg_name2" {
  default = ""
}
variable "sg_name3" {
  default     = ""
}
variable "sg_name4" {
  default     = ""
}
variable "all" {
    default = ["0.0.0.0/0"]
    description = "this cidr block is open to the world"
}
variable "public_cidr" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "port_ssh" {
  default     = 22
  description = "this port allows ssh access"
}
variable "port_http" {
  default     = 80
  description = "this port allows http access"
}
variable "port_mysql" {
  default     = 3306
  description = "this port allows msql access"
}
variable "egress" {
  default = "0"
}