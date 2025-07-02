data "azurerm_mssql_server" "mssql_server" {
  name                = var.mssql_server_name
  resource_group_name = var.mssql_server_resource_group_name
}


resource "azurerm_mssql_database" "mssql_database" {
  name         = var.mssql_database_name
  server_id    = data.azurerm_mssql_server.mssql_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_mssql_firewall_rule" "mssql_firewall_rule" {
  name             = var.mssql_firewall_rule_name
  server_id        = data.azurerm_mssql_server.mssql_server.id
  start_ip_address = var.mssql_firewall_rule_start_ip_address
  end_ip_address   = var.mssql_firewall_rule_end_ip_address
}


