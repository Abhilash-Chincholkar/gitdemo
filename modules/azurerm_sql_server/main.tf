resource "azurerm_mssql_server" "mssql_server" {
  name                         = var.mssql_server_name
  resource_group_name          = var.mssql_server_resource_group_name
  location                     = var.mssql_server_location
  version                      = "12.0"
  administrator_login          = var.mssql_server_administrator_login
  administrator_login_password = var.mssql_server_administrator_login_password
  minimum_tls_version          = "1.2"
}

