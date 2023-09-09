

terraform {
  required_providers {
    aws = {
      version = ">= 5.0"
      source  = "hashicorp/aws"
    }
  }
}


provider "aws" {
  region = "us-east-1"

}


resource "aws_instance" "my-aws" {
  #ami           = "ami-01c647eace872fc02"
  instance_type = var.my_ami
  key_name      = var.aws_key_pair
  ami           = data.aws_ami.ec2_instance.id
  user_data     = file("${path.module}/httpd.sh")

  tags = {
    Name = "Don"
    env  = "prod"
  }

}

data "aws_ami" "ec2_instance" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    #values = ["RHEL-9.2.0_HVM-20230503-x86_64-41-Hourly2-GP2*"]  

  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

variable "my_ami" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = string
  default     = "t2.micro"
}
variable "aws_key_pair" {
  description = "this is private key for ssh"
  type        = string
  default     = "kaka"
}


output "instance_ip_addr" {
  value       = aws_instance.my-aws.public_ip
  description = "The public IP address of the main server instance."


}
/*resource "aws_eip" "myip" {
  instance = aws_instance.my-aws.id
  domain   = "vpc"
}*/

resource "aws_vpc" "donnet" {
  cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"

  tags = {
    Name = "donnet"
  }
}