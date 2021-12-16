terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "joanlei"

    workspaces {
      name = "api_ws"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}



#resource "random_pet" "sg" {}

#resource "aws_instance" "web" {
#  ami                    = "ami-830c94e3"
#  instance_type          = "t2.micro"
#  vpc_security_group_ids = [aws_security_group.web-sg.id]

#  user_data = <<-EOF
#              #!/bin/bash
#              echo "Hello, World" > index.html
#              nohup busybox httpd -f -p 8080 &
#              EOF
#}

#resource "aws_security_group" "web-sg" {
#  name = "${random_pet.sg.id}-sg"
#  ingress {
#    from_port   = 8080
#    to_port     = 8080
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}

#output "web-address" {
#  value = "${aws_instance.web.public_dns}:8080"
#
#}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  #tags = {
  #  Terraform = "true"
  #  Environment = "dev"
  #}
}



