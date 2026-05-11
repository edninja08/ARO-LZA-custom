data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "spoke" {
  name = var.spoke_rg_name
}

resource "random_integer" "sql" {
  min = 10000
  max = 99999
}

locals {
  sql_server_name = "${var.sql_server_base_name}${random_integer.sql.result}"
}
