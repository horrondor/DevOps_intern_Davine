variable "REGION" {
  type    = string
  default = "ap-south-1"
}

variable "ec2_instance_name" {
  type = string
}
variable "ec2_instance_type" {
  type = string
}

variable "ec2_no_of_instance" {
  type = number
}

variable "ec2_zone_name" {
  type = string
}

variable "ec2_key_name" {
  type = string
}