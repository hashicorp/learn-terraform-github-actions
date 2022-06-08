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
    organization = "github-actions-terraform-ec2"

    workspaces {
      name = "github-actions-terraform-ec2"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}


resource "aws_instance" "EC2-Instance" {
  ami             = "ami-0487b1fe60c1fd1a2"
  key_name 	      = "yogender_new_aws_keypair"
  instance_type   = "t2.micro"
  security_groups = ["EC2-security-group"]
  

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              echo "Hello World" > /var/www/html/index.html
              systemctl restart apache2
              EOF
  tags= {
    Name = "terraform-git"
  }
}

resource "aws_security_group" "web-sg" {
  name = "EC2-security-group"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // connectivity to ubuntu mirrors is required to run `apt-get update` and `apt-get install apache2`
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags= {
    Name = EC2-security-group
  }
}

output "web-address" {
  value = "${aws_instance.EC2-Instance.public_dns}"
}
