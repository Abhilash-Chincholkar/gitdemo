module "azurerm_resource_group" {
  source = "../modules/azurerm_resource_group"
  resource_group_name     = "todo-resource-group"
  resource_group_location = "switzerlandnorth"
}
module "azurerm_virtual_network" {
  depends_on = [module.azurerm_resource_group]
  source = "../modules/azurerm_virtual_network"
  vnet_name    = "todo-virtual-network"
  vnet_resource_group_name = "todo-resource-group"
  vnet_resource_group_location = "switzerlandnorth"
  vnet_address_space = ["10.0.0.0/16"] 
}
module "azurerm_subnet" {
  depends_on = [module.azurerm_virtual_network]
  source = "../modules/azurerm_subnet"
  subnet_name = "todo-subnet"
  subnet_virtual_network_name = "todo-virtual-network"
  subnet_resource_group_name = "todo-resource-group"
  subnet_address_prefixes = ["10.0.1.0/24"]
}
module "azurerm_public_ip" {
  depends_on = [module.azurerm_resource_group]
  source = "../modules/azurerm_public_ip"
  public_ip_name = "todo-public-ip"
  public_ip_resource_group_name = "todo-resource-group"
  public_ip_location = "switzerlandnorth"
}
module "azurerm_network_security_group" {
  depends_on = [module.azurerm_resource_group]
  source = "../modules/azurerm_network_security_group"
  network_security_group_name = "todo-network-security-group"
  network_security_group_resource_group_name = "todo-resource-group"
  network_security_group_location = "switzerlandnorth"
  security_rule_name = "AllowSSH"
  security_rule_priority = 1000
  security_rule_direction = "Inbound"
  security_rule_destination_port_range = "*"
}

module "azurerm_keyvault" {
  depends_on = [module.azurerm_resource_group]
  source = "../modules/azurerm_keyvault"
  keyvault_name = "todo-keyvault-test-pc"
  keyvault_resource_group_name = "todo-resource-group"
  keyvault_location = "switzerlandnorth"
}
module "vm-username" {
  depends_on = [module.azurerm_keyvault]
  source = "../modules/azurerm_keyvault_secret"
  key_vault_name = "todo-keyvault-test-pc"
  resource_group_name = "todo-resource-group"
  secret_name = "vm-username"
  secret_value = "azureuser"
}
module "vm-password" {
  depends_on = [module.azurerm_keyvault]
  source = "../modules/azurerm_keyvault_secret"
  key_vault_name = "todo-keyvault-test-pc"
  resource_group_name = "todo-resource-group"
  secret_name = "vm-password"
  secret_value = "Abhilash@7878"
}
module "azurerm_mssql_server" {
  depends_on = [module.azurerm_resource_group]
  source = "../modules/azurerm_sql_server"
  mssql_server_name = "todosqlservertest"
  mssql_server_resource_group_name = "todo-resource-group"
  mssql_server_location = "switzerlandnorth"
  mssql_server_administrator_login = "sqladmin"
  mssql_server_administrator_login_password = "P@ssw0rd1234!"
}
module "azurerm_mssql_database" {
  depends_on = [module.azurerm_mssql_server]
  source = "../modules/azurerm_sql_database"
  mssql_server_name = "todosqlservertest"
  mssql_server_resource_group_name = "todo-resource-group"
  mssql_database_name = "tododb"
  mssql_firewall_rule_name = "AllowAllAzureIPs"
  mssql_firewall_rule_start_ip_address = "106.215.0.0"
  mssql_firewall_rule_end_ip_address = "106.215.255.255"
}
module "azurerm_virtual_machine" {
    depends_on = [
        module.azurerm_resource_group,
        module.azurerm_virtual_network,
        module.azurerm_subnet,
        module.azurerm_public_ip,
        module.azurerm_network_security_group,
        module.azurerm_keyvault,
        module.vm-username,
        module.vm-password
    ]
  source = "../modules/azurerm_virtual_machine"
  virtual_machine_name = "todo-virtual-machine"
  virtual_machine_resource_group_name = "todo-resource-group"
  virtual_machine_location = "switzerlandnorth"
  virtual_machine_size = "Standard_B1s"
  virtual_machine_admin_username = null
  virtual_machine_admin_password = null
  network_interface_name = "todo-nic"
  network_interface_location = "switzerlandnorth"
  network_interface_resource_group_name = "todo-resource-group"
  subnet_name = "todo-subnet"
  subnet_virtual_network_name = "todo-virtual-network"  
  subnet_resource_group_name = "todo-resource-group"
  public_ip_name = "todo-public-ip"
  public_ip_resource_group_name = "todo-resource-group"
  network_security_group_name = "todo-network-security-group"
  network_security_group_resource_group_name = "todo-resource-group"
  key_vault_name = "todo-keyvault-test-pc"
  key_vault_resource_group_name = "todo-resource-group"
  vm_username_secret_name = "vm-username"
  vm_password_secret_name = "vm-password"
}