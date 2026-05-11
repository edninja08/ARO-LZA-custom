# -------------------------------------------------------------------
# Azure SQL Database (PaaS) - Clinical Workflow Database
# Private endpoint ensures data stays within the virtual network.
# All sizing parameters are exposed as optional variables so the
# database can be right-sized per customer requirements.
# -------------------------------------------------------------------

resource "azurerm_mssql_server" "sql" {
  name                         = local.sql_server_name
  location                     = var.location
  resource_group_name          = var.spoke_rg_name
  version                      = var.sql_server_version
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"
  tags                         = var.tags

  public_network_access_enabled = false

  azuread_administrator {
    login_username = var.sql_aad_admin_login
    object_id      = var.sql_aad_admin_object_id
  }
}

resource "azurerm_mssql_database" "db" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.sql.id
  tags      = var.tags

  # Sizing — all optional with sensible defaults
  sku_name                    = var.sql_sku_name
  max_size_gb                 = var.sql_max_size_gb
  zone_redundant              = var.sql_zone_redundant
  read_scale                  = var.sql_read_scale
  auto_pause_delay_in_minutes = var.sql_auto_pause_delay_in_minutes
  min_capacity                = var.sql_min_capacity

  short_term_retention_policy {
    retention_days           = var.sql_backup_retention_days
    backup_interval_in_hours = var.sql_backup_interval_in_hours
  }

  dynamic "long_term_retention_policy" {
    for_each = var.sql_long_term_retention_enabled ? [1] : []
    content {
      weekly_retention  = var.sql_ltr_weekly_retention
      monthly_retention = var.sql_ltr_monthly_retention
      yearly_retention  = var.sql_ltr_yearly_retention
      week_of_year      = var.sql_ltr_week_of_year
    }
  }
}

# -------------------------------------------------------------------
# Private Endpoint for Azure SQL
# -------------------------------------------------------------------

resource "azurerm_private_endpoint" "sql" {
  name                = "sqlPvtEndpoint"
  resource_group_name = var.spoke_rg_name
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "sqlConnection"
    private_connection_resource_id = azurerm_mssql_server.sql.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  private_dns_zone_group {
    name = "SQL-ZoneGroup"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.sql.id
    ]
  }
}

# -------------------------------------------------------------------
# Private DNS Zone for Azure SQL
# -------------------------------------------------------------------

resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.spoke_rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_spoke" {
  name                  = "SQLDNSLink"
  resource_group_name   = var.spoke_rg_name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = var.spoke_vnet_id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_hub" {
  name                  = "SQLDNSLinkHub"
  resource_group_name   = var.spoke_rg_name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = var.hub_vnet_id
  registration_enabled  = false
}

# -------------------------------------------------------------------
# Diagnostic Settings for Azure SQL
# -------------------------------------------------------------------

resource "azurerm_monitor_diagnostic_setting" "sql_diag" {
  name                       = "sqlToLogAnalytics"
  target_resource_id         = azurerm_mssql_database.db.id
  log_analytics_workspace_id = var.la_id

  enabled_log {
    category = "SQLInsights"
  }

  enabled_log {
    category = "QueryStoreRuntimeStatistics"
  }

  enabled_log {
    category = "Errors"
  }

  metric {
    category = "Basic"
  }

  metric {
    category = "InstanceAndAppAdvanced"
  }
}
