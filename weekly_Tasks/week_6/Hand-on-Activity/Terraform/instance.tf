data "aws_ami" "cloud_raju" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "my_ec2_instance" {
  source             = "./New_module"
  ec2_instance_type  = var.ec2_instance_type
  ec2_instance_name  = var.ec2_instance_name
  ec2_no_of_instance = var.ec2_no_of_instance
  ec2_zone_name      = var.ec2_zone_name
  ec2_key_name       = var.ec2_key_name
  ec2_ami_id         = data.aws_ami.cloud_raju.id

}