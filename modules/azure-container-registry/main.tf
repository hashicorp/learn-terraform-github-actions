resource "azurerm_container_registry" "main" {
  name                = var.container_registry_name
  resource_group_name = var.resource_group_name
  location            = var.container_registry_location
  sku                 = var.container_registry_sku
  admin_enabled       = var.container_registry_adminenabled
  georeplications {
    location                = var.container_registry_georeplications_1_location
    zone_redundancy_enabled = var.container_registry_georeplications_1_zone_redundancy_enabled
  }
  
  georeplications {
    location                = var.container_registry_georeplications_1_location
    zone_redundancy_enabled = var.container_registry_georeplications_1_zone_redundancy_enabled
  }
}