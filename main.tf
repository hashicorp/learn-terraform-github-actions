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
  required_version = ">= 1.00"

  backend "remote" {
    organization = "toyamagu"

    workspaces {
      name = "github-actions-demo"
    }
  }
}


provider "aws" {
  region = "ap-northeast-1"
}



resource "random_pet" "sg" {}

resource "aws_instance" "web" {
  ami                    = "ami-0e60b6d05dc38ff11"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id = "${var.subnet_id}"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = { 
    Name = "toyamagu-github-terraform"
  }
}

resource "aws_security_group" "web-sg" {
  name = "toyamagu-${random_pet.sg.id}-sg"
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "web-address" {
  value = "${aws_instance.web.public_dns}:8080"
}
