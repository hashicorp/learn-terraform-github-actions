terraform {
  required_providers {
    azurem = {
      source  = "hashicorp/azurem"
      version = ">=2.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = "~> 0.14"

  backend "remote" {
    organization = "zm-intern06"

    workspaces {
      name = "github-integration"
    }
  }
}


provider "azurem" {
  region = "us-west-2"
}

resource "azurerm_resource_group" "rg-hello-azure" {
  name     = "rg-hello-azure"
  location = "northcentralus"
}

