
terraform {
  backend "s3" {
    bucket = "my-terraform-state-sss"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "allow_http_ssh" {
  name = "allow_http_ssh_v2"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "ec2_instances" {
  source         = "./modules/ec2_instance"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  security_group = aws_security_group.allow_http_ssh.name
  user_data      = file("user_data.sh")
  instance_count = var.instance_count
  instance_name  = "springboot"
}
