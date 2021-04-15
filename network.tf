resource "azurerm_network_security_group" "wus-nsg" {
  name                = "NSGS1"
  location            = azurerm_resource_group.wus-rg.location
  resource_group_name = azurerm_resource_group.wus-rg.name
}

resource "azurerm_virtual_network" "example" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.wus-rg.location
  resource_group_name = azurerm_resource_group.wus-rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

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

  subnet {
    name           = "AzureFirewallSubnet"
    address_prefix = "10.0.4.0/24"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_route_table" "wus-rt" {
  name                = "example-routetable"
  location            = azurerm_resource_group.wus-rg.location
  resource_group_name = azurerm_resource_group.wus-rg.name

  route {
    name                   = "example"
    address_prefix         = "0.0.0.0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.1"
  }
}

resource "azurerm_subnet_route_table_association" "wus-rt-association-1" {
  subnet_id      = (azurerm_virtual_network.example.subnet[*])[0].id
  route_table_id = azurerm_route_table.wus-rt.id
}

resource "azurerm_subnet_route_table_association" "wus-rt-association-2" {
  subnet_id      = (azurerm_virtual_network.example.subnet[*])[1].id
  route_table_id = azurerm_route_table.wus-rt.id
}

resource "azurerm_subnet_route_table_association" "wus-rt-association-3" {
  subnet_id      = (azurerm_virtual_network.example.subnet[*])[2].id
  route_table_id = azurerm_route_table.wus-rt.id
}
