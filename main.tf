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
  organization = "CCTest99"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}