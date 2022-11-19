terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.3.0"
    }
  }

  cloud {
    organization = "CameronOrganisation"

    workspaces {
      name = "github-integration-test"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "terraform-deployed-rg"
  location = "Uk South"
}