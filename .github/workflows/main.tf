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
    organization = "REPLACE_ME"



   workspaces {
      name = "gh-actions-demo"
    }
  }
}
