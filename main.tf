## test ##
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "remote" {
    organization = "github_action"

    workspaces {
      name = "gh-actions-demo2"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

provider "random" {}

resource "random_pet" "sg" {}

resource "aws_instance" "web" {
  ami                    = "ami-006e2f9fa7597680a"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World1" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
}

resource "aws_security_group" "web-sg" {
  name = "${random_pet.sg.id}-sg"
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

