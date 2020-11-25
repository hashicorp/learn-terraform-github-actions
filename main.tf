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
    organization = "REPLACE_ME"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "google" {
  version = "3.5.0"
  #credentials = file(var.credential_file)
  #project = var.project_id
}


#creating a storage bucket in GCP
resource "google_storage_bucket" "bucket1" {
  project = "vasu-pratice1-terraform-admin"
  name = "API-test-bucket"
  location = "us-east1"
  storage_class = "REGIONAL"
}
