terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.89.0"
    }
  }
  backend "remote" {
    organization = "example-org-a06ce0"

    workspaces {
      name = "gh-actions-trendfeed"
    }
  }
}

provider "google" {
  region  = var.region
  project = var.project_id
  credentials = file(var.credentials)

}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "n1-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "terraform-sa@valid-hall-328809.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}