data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.subnet_virtual_network_name
  resource_group_name  = var.subnet_resource_group_name
}
data "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.public_ip_resource_group_name
}
data "azurerm_network_security_group" "network_security_group" {
  name                = var.network_security_group_name
  resource_group_name = var.network_security_group_resource_group_name
}
data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}
data "azurerm_key_vault_secret" "vm_username" {
  name         = var.vm_username_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
data "azurerm_key_vault_secret" "vm_password" {
  name         = var.vm_password_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
} 
