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
  required_version = "~> 1.0"

  backend "remote" {
    organization = "cybersecurity-homeschooling"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}



//module "server" {
//  source = "github.com/imchristianlowe/tf-modules//test?ref=v1.0.0"
//}
//
//output "url" {
//  value = module.server.web-address
//}