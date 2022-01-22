resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.resource_group_location

  tags = {
    environment = var.resource_group_tags_environment
  }
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.aks_cluster_dnsprefix

  default_node_pool {
    name            = var.aks_cluster_nodepool_name
    node_count      = var.aks_cluster_nodepool_nodecount
    vm_size         = var.aks_cluster_nodepool_vmsize
    os_disk_size_gb = var.aks_cluster_nodepool_os_disk_size_gb
  }

  service_principal {
    client_id     = var.ARM_CLIENT_ID
    client_secret = var.ARM_CLIENT_SECRET
  }

  role_based_access_control {
    enabled = var.aks_cluste_rbac_enabled
  }

  tags = {
    environment = var.resource_group_tags_environment
    
  }
}
