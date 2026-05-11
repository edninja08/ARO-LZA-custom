output "console_url" {
  value = module.aro.console_url
}

output "api_server_ip" {
  value = module.aro.api_server_ip
}

output "ingress_ip" {
  value = module.aro.ingress_ip
}

output "AFD_endpoint_FQDN" {
  value = module.frontdoor.AFD_endpoint
}

output "vm_admin_username" {
  value = var.vm_admin_username
}

output "vm_admin_password" {
  value = module.kv.vm_admin_password
  sensitive = true    
  }

output "kv_hub_name" {
  value = module.kv.kv_hub_name
}

output "sql_server_name" {
  value = module.platform.sql_server_name
}

output "sql_server_fqdn" {
  value = module.platform.sql_server_fqdn
}

output "sql_database_name" {
  value = module.platform.sql_database_name
}

output "acr_login_server" {
  value = module.supporting.acr_login_server
}

output "helm_deploy_script" {
  value       = module.platform.helm_deploy_script_path
  description = "Path to the Helm deployment script — run from the jumpbox VM"
}