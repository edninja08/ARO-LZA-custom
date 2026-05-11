output "sql_server_name" {
  value       = azurerm_mssql_server.sql.name
  description = "The Azure SQL Server name"
}

output "sql_server_fqdn" {
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
  description = "The fully qualified domain name of the Azure SQL Server"
}

output "sql_database_name" {
  value       = azurerm_mssql_database.db.name
  description = "The Azure SQL Database name"
}

output "sql_connection_string" {
  value       = "Server=tcp:${azurerm_mssql_server.sql.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.db.name};"
  sensitive   = true
  description = "The ADO.NET connection string prefix for Azure SQL (append authentication details)"
}

output "helm_deploy_script_path" {
  value       = local_file.helm_deploy_script.filename
  description = "Path to the generated Helm deployment script (run from jumpbox)"
}
