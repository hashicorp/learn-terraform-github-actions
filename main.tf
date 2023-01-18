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
    organization = "abhikumar8"

    workspaces {
      name = "cli-workspace"
    }
  }
}



provider "google" {
  project = var.project_id
  credentials=var.gcp_key
}