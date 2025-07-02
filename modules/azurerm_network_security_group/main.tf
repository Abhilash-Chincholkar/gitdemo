resource "azurerm_network_security_group" "network_security_group" {
  name                = var.network_security_group_name
  location            = var.network_security_group_location
  resource_group_name = var.network_security_group_resource_group_name

  security_rule {
    name                       = var.security_rule_name
    priority                   = var.security_rule_priority
    direction                  = var.security_rule_direction
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.security_rule_destination_port_range
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
