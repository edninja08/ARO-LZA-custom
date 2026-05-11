# -------------------------------------------------------------------
# Key Vault Secrets — Store Azure SQL connection details so that
# application pods can retrieve them via the CSI Secrets Store driver
# or Helm chart values.
# -------------------------------------------------------------------

resource "azurerm_key_vault_secret" "sql_connection_string" {
  name         = "sql-connection-string"
  value        = "Server=tcp:${azurerm_mssql_server.sql.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.db.name};Persist Security Info=False;User ID=${var.sql_admin_username};Password=${var.sql_admin_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = var.spoke_keyvault_id
}

resource "azurerm_key_vault_secret" "sql_server_fqdn" {
  name         = "sql-server-fqdn"
  value        = azurerm_mssql_server.sql.fully_qualified_domain_name
  key_vault_id = var.spoke_keyvault_id
}

resource "azurerm_key_vault_secret" "sql_admin_username" {
  name         = "sql-admin-username"
  value        = var.sql_admin_username
  key_vault_id = var.spoke_keyvault_id
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  value        = var.sql_admin_password
  key_vault_id = var.spoke_keyvault_id
}
