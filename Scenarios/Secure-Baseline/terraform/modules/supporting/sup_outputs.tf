output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "The resource ID of the Azure Container Registry"
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "The login server URL for the Azure Container Registry"
}

output "spoke_keyvault_id" {
  value       = azurerm_key_vault.sub_kv.id
  description = "The resource ID of the spoke Key Vault"
}
