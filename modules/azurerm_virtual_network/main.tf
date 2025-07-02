resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
  location            = var.vnet_resource_group_location
  address_space       = var.vnet_address_space
}

