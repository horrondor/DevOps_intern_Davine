resource "aws_instance" "instance1" {
  ami                     = var.ec2_ami_id
  instance_type           = var.ec2_instance_type
  availability_zone       = var.ec2_zone_name
  key_name                = var.ec2_key_name

  tags = {
    Name = var.ec2_instance_name
  }
}