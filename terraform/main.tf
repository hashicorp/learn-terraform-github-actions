#terraform {
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "3.26.0"
#    }
#    random = {
#      source  = "hashicorp/random"
#      version = "3.0.1"
#    }
#  }
#  required_version = "~> 0.14"
#
#  backend "remote" {
#    organization = "fr-dev"
#
#    workspaces {
#      name = "gh-actions-demo"
#    }
#  }
#}
#
#
#provider "aws" {
#  region = "us-west-2"
#}

terraform {
  backend "remote" {
    organization = "fr-dev"

    workspaces {
      name = "gh-actions-demo"
  }
}
 
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}
 
data "azurerm_client_config" "current" {}
 
#Create Resource Group
resource "azurerm_resource_group" "TF-github-actions-test" {
  name     = "TF-github-actions-test"
  location = "westeurope"
}
 
#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "TF-github-actions-test-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.TF-github-actions-testname
}
 
# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.TF-github-actions-test.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}

