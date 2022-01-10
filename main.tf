terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.71.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "akutay"

    workspaces {
      name = "github-actions-demo"
    }
  }
}


provider "aws" {
  region = "us-west-1"
}


// Security group with no ingress rule
resource "aws_security_group" "no-ingress-sg" {
  description = "Security group with no ingress rule for testing."
  name        = "test-sg-no-ingress-${var.environment}"

  tags = merge(var.default_tags, {
    "Name" = "Dist-playout-no-ingress-sg-test"
  })
}




# resource "aws_instance" "web" {
#   ami                    = "ami-830c94e3"
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.web-sg.id]

#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, World" > index.html
#               nohup busybox httpd -f -p 8080 &
#               EOF
# }

# resource "aws_security_group" "web-sg" {
#   name = "${random_pet.sg.id}-sg"
#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# output "web-address" {
#   value = "${aws_instance.web.public_dns}:8080"
# }
