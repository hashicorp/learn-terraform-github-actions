terraform {
  required_version = ">= 1.1.0"

  cloud {
    organization = "commerceprowess"
    workspaces {
      name = "notejam-azure"
    }
  }
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.resource_group_location

  tags = {
    environment = "production"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = var.aks_cluster_dnsprefix

  default_node_pool {
    name            = var.aks_cluster_default_node_pool_name
    node_count      = var.aks_cluster_default_node_pool_nodecount
    vm_size         = var.aks_cluster_default_node_pool_vmsize
    os_disk_size_gb = var.aks_cluster_default_node_pool_os_disk_size_gb
  }

  service_principal {
    client_id     = var.ARM_CLIENT_ID
    client_secret = var.ARM_CLIENT_SECRET
  }

  role_based_access_control {
    enabled = var.aks_cluster_default_role_based_access_control_enabled
  }

  tags = {
    environment = var.aks_cluster_default_tags_environment
  }
}
