terraform {
 required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

   backend "azurerm" {
    resource_group_name  = "ibinder-resource-group3"
    storage_account_name = "ibinderstorage"
    container_name       = "tfstate"
    key                  = "terraformgithubexample.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}


resource "azurerm_resource_group" "rg"{
  name     = "terraformIbinderResourceGroup"
  location = "northeurope"
    tags = {
    Owner = "john.chimbani"
    DueDate = "2022-11-02"
  }
}




