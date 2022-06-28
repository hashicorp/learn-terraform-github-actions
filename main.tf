terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.1.0"
  backend "gcs" {
    bucket = "cicd-playground-liaurora"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.location
}

provider "google-beta" {
  project = var.project_id
  region  = var.location
}

provider "github" {
  token = var.token
  alias = "github"
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
  account_id   = "github-sa"
  display_name = "Github Service Account"
}

resource "google_project_iam_member" "gke" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_project_iam_member" "gcr" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

data "google_container_cluster" "demo_cluster" {
  name     = "demo"
  location = "${var.location}-c"
}

module "hello_service" {
  providers = {
    github = github.github
  }
  source            = "./modules/new_svc"
  service_name      = "hello"
  workload_identity = module.gh_oidc.provider_name
  service_account   = google_service_account.gke_sa.email
  project_id        = var.project_id
  cluster           = "demo"
  location          = "${var.location}-c"
}


module "goodbye_service" {
  providers = {
    github = github.github
  }
  source            = "./modules/new_svc"
  service_name      = "goodbye"
  workload_identity = module.gh_oidc.provider_name
  service_account   = google_service_account.gke_sa.email
  project_id        = var.project_id
  cluster           = "demo"
  location          = "${var.location}-c"
}