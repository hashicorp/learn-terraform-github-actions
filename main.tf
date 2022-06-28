terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.1.0"

}

provider "google" {
  project     = "cicd-playground-354219"
  region      = "us-central1"
}

provider "google-beta" {
  project     = "cicd-playground-354219"
  region      = "us-central1"
}



module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = "github-pool"
  provider_id = "gh-provider"
  sa_mapping = {
    "gke-service-account" = {
      sa_name   = google_service_account.gke_sa.id
      attribute = "*"
    }
  }
}
resource "google_service_account" "gke_sa" {
  account_id   = "github_sa"
  display_name = "Github Service Account"
}
