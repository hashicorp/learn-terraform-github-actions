terraform {
  required_providers {
    aws = {
      source = "hashicorp/google"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "remote" {
    organization = "Terraform-User-0054"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "google" {
  version = "3.5.0"
  
}


#creating a storage bucket in GCP
resource "google_storage_bucket" "git-test-vasu-bucket" {
  project = "vasu-pratice1-terraform-admin"
  name = "api-test-bucket-git"
  location = "us-east1"
  storage_class = "REGIONAL"
}
