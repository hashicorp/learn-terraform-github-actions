terraform {
 required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

  cloud {
    organization = "chimbani"

    workspaces {
      name = "ibinderTerraformModules"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg"{
  name     = "terraformIbinderResourceGroup"
  location = "northeurope"
    tags = {
    Owner = "john.chimbani"
    DueDate = "2022-11-02"
  }
}




