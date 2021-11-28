terraform {
  required_version = ">= 0.12"
  backend "gcs" {
    bucket = "bam-tf-state-prod"
  }
}

locals {
  environments_project = {
    dev    = "bam-big-data-dev",
    prodga = "bam-big-data-312108"
  }

  env_id = terraform.workspace

  project_id = lookup(local.environments_project, terraform.workspace)
  region     = "us-central1"
  zone       = "us-central1-c"
  bq_loction = "US"
}

provider "google" {
  project = local.project_id
  region  = local.region
  zone    = local.zone
}

resource "google_storage_bucket" "test_gh" {
  name          = "test_gh_demo"
}