# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------

output "id" {
  description = "The ID of the NetApp Account."
  value       = var.create ? azurerm_netapp_account.this[0].id : null
}

output "name" {
  description = "The name of the NetApp Account."
  value       = var.create ? azurerm_netapp_account.this[0].name : null
}

output "location" {
  description = "The Azure region where the NetApp Account is located."
  value       = var.create ? azurerm_netapp_account.this[0].location : null
}
