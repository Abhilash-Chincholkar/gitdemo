resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.public_ip_resource_group_name
  location            = var.public_ip_location
  allocation_method   = "Static"
}

