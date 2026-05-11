output "sp_client_id" {
    value = azuread_application.aro-lza-sp.client_id
}

output "sp_client_secret" {
    value = azuread_service_principal_password.aro-lza-sp.value
    sensitive=true
}

output "sp_object_id" {
    value = azuread_service_principal.aro-lza-sp.object_id
    description = "The object ID of the ARO service principal"
}

#output "sp_client_secret" {
#    value = azuread_application_password.sp_client_secret.value
#    sensitive=true
#}
