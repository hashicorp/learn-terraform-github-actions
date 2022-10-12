terraform {
  cloud {
    organization = "Demo-Lydia"
    workspaces {
      name = "learn-terraform-github-actions"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
  } 

provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "web"{
  ami                    = "ami-02d0b1ffa5f16402d"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0d77553dc9abeae0e"

 tags = {
    Name = "ExampleAppServer"
  }
}
