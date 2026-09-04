variable "REGION" {
  default = "ap-south-1"
}

variable "ZONE1" {
  default = "ap-south-1a"
}

variable "AMIS" {
  type = map(any)
  default = {
    ap-south-1 = "ami-0f9550baf23afe812"
    
  }
}