# -------------------------------------------------------------------
# ACR ↔ ARO Integration — Secure Image Pulls
# Grants AcrPull role to the ARO service principal so that cluster
# worker nodes can pull container images from the private ACR.
# -------------------------------------------------------------------

resource "azurerm_role_assignment" "aro_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = var.aro_sp_object_id
}
