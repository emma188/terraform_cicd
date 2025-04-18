
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "security_group" {}
variable "user_data" {}
variable "instance_count" {}
variable "instance_name" {
  default = "springboot"
}
