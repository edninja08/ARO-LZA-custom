variable "location" {
  type        = string
  description = "The Azure region for resource deployment"
}

variable "spoke_rg_name" {
  type        = string
  description = "The name of the spoke resource group"
}

variable "hub_rg_name" {
  type        = string
  description = "The name of the hub resource group"
}

variable "hub_vnet_id" {
  type        = string
  description = "The resource ID of the hub virtual network"
}

variable "spoke_vnet_id" {
  type        = string
  description = "The resource ID of the spoke virtual network"
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "The subnet ID for private endpoints"
}

# Azure SQL Database Configuration

variable "sql_server_base_name" {
  type        = string
  default     = "aroplatsql"
  description = "Base name for the Azure SQL Server (alphanumeric, lowercase)"
}

variable "sql_server_version" {
  type        = string
  default     = "12.0"
  description = "The version of the Azure SQL Server"
}

variable "sql_admin_username" {
  type        = string
  default     = "sqladmin"
  description = "The SQL Server administrator login username"
}

variable "sql_admin_password" {
  type        = string
  sensitive   = true
  description = "The SQL Server administrator login password"
}

variable "sql_aad_admin_login" {
  type        = string
  description = "The Azure AD administrator login name for the SQL Server"
}

variable "sql_aad_admin_object_id" {
  type        = string
  description = "The Azure AD administrator object ID for the SQL Server"
}

variable "sql_database_name" {
  type        = string
  default     = "clinicalworkflow"
  description = "The name of the SQL database"
}

# Sizing — use these variables to right-size per customer requirements

variable "sql_sku_name" {
  type        = string
  default     = "GP_S_Gen5_2"
  description = "The SKU name for the SQL database (e.g. GP_S_Gen5_2 for serverless General Purpose, GP_Gen5_4 for provisioned, BC_Gen5_2 for Business Critical, HS_Gen5_2 for Hyperscale)"
}

variable "sql_max_size_gb" {
  type        = number
  default     = 32
  description = "The maximum size of the database in gigabytes"
}

variable "sql_zone_redundant" {
  type        = bool
  default     = false
  description = "Whether the database is zone redundant (recommended for production)"
}

variable "sql_read_scale" {
  type        = bool
  default     = false
  description = "Enable read scale-out for read-intensive workloads (Business Critical / Hyperscale)"
}

variable "sql_auto_pause_delay_in_minutes" {
  type        = number
  default     = 60
  description = "Time in minutes after which the serverless database is auto-paused (-1 to disable). Only applies to serverless SKUs (GP_S_*)."
}

variable "sql_min_capacity" {
  type        = number
  default     = 0.5
  description = "Minimum vCore capacity for serverless SKU. Only applies to serverless SKUs (GP_S_*)."
}

# Backup & Retention

variable "sql_backup_retention_days" {
  type        = number
  default     = 7
  description = "Number of days for short-term backup retention (1-35)"
}

variable "sql_backup_interval_in_hours" {
  type        = number
  default     = 12
  description = "Hours between differential backups (12 or 24)"
}

variable "sql_long_term_retention_enabled" {
  type        = bool
  default     = false
  description = "Enable long-term backup retention (LTR) policies"
}

variable "sql_ltr_weekly_retention" {
  type        = string
  default     = "P4W"
  description = "Weekly LTR retention period in ISO 8601 duration format"
}

variable "sql_ltr_monthly_retention" {
  type        = string
  default     = "P12M"
  description = "Monthly LTR retention period in ISO 8601 duration format"
}

variable "sql_ltr_yearly_retention" {
  type        = string
  default     = "P5Y"
  description = "Yearly LTR retention period in ISO 8601 duration format"
}

variable "sql_ltr_week_of_year" {
  type        = number
  default     = 1
  description = "The week of the year for the yearly LTR backup"
}

# ACR Integration
variable "acr_id" {
  type        = string
  description = "The resource ID of the Azure Container Registry"
}

variable "aro_sp_object_id" {
  type        = string
  description = "The object ID of the ARO service principal (for AcrPull role assignment)"
}

# Key Vault Integration
variable "spoke_keyvault_id" {
  type        = string
  description = "The resource ID of the spoke Key Vault to store connection strings"
}

# ARO Cluster Reference
variable "aro_cluster_name" {
  type        = string
  description = "The name of the ARO cluster"
}

variable "aro_api_server_url" {
  type        = string
  description = "The ARO cluster API server URL (from ARO module console_url)"
}

variable "aro_ingress_ip" {
  type        = string
  description = "The ARO ingress controller IP address"
}

# Helm Configuration
variable "helm_chart_repository" {
  type        = string
  default     = ""
  description = "The Helm chart repository URL for the application"
}

variable "helm_chart_name" {
  type        = string
  default     = "quantech-platform"
  description = "The Helm chart name for the application deployment"
}

variable "helm_chart_version" {
  type        = string
  default     = ""
  description = "The Helm chart version to deploy"
}

variable "helm_namespace" {
  type        = string
  default     = "quantech"
  description = "The Kubernetes namespace for the Helm release"
}

variable "random" {
  type        = string
  description = "Random string for resource name uniqueness"
}

variable "la_id" {
  type        = string
  description = "The resource ID of the Log Analytics workspace for diagnostics"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources in this module"
}
