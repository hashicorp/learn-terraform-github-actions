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
  required_version = ">= 0.14"

  backend "remote" {
    organization = "aureliomalheiros"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}


provider "aws" {
  region = "us-west-1"
}