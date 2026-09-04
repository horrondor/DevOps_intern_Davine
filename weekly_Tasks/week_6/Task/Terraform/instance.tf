resource "aws_instance" "Raju-vm" {
  ami                     = var.AMIS[var.REGION]
  instance_type           = "t3.micro"
  availability_zone       = var.ZONE1
  key_name                = "Personal_access_key"
  vpc_security_group_ids = ["sg-09c18c8a33bd773ae"]
  tags = {
    Name    = "Raju-terraform"
    Project = "Devops"
  }

}