terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }



 cloud {
    organization = "Devops702"



   workspaces {
      name = "gh-actions-demo"
    }
  }
}
