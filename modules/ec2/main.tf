data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "devops_ec2_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }

  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.enable_associate_public_ip_address
  vpc_security_group_ids      = [var.sg_enable_ssh_https, var.ec2_sg_name_for_python_api]
  key_name                    = "aws_key"

  user_data = var.user_data_install_script

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  lifecycle {
    ignore_changes = [security_groups, associate_public_ip_address]
  }
}

resource "aws_key_pair" "public_key" {
  key_name   = "aws_key"
  public_key = var.public_key
}
