terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "remote" {
    organization = "gigler"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}
