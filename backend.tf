terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = "~> 0.14"

  backend "remote" {
    organization = "namitjagtiani"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "azurerm" {
  features {}
}