resource "azurerm_network_security_group" "wus-nsg" {
  name                = "NSGS1"
  location            = azurerm_resource_group.wus-rg.location
  resource_group_name = azurerm_resource_group.wus-rg.name
}

# resource "azurerm_network_ddos_protection_plan" "ddos-plan" {
#   name                = "ddospplan1"
#   location            = azurerm_resource_group.wus-rg.location
#   resource_group_name = azurerm_resource_group.wus-rg.name
# }

resource "azurerm_virtual_network" "example" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.wus-rg.location
  resource_group_name = azurerm_resource_group.wus-rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

#   ddos_protection_plan {
#     id     = azurerm_network_ddos_protection_plan.ddos-plan.id
#     enable = false
#   }

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.wus-nsg.id
  }

  tags = {
    environment = "Production"
  }
}