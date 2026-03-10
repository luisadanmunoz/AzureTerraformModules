################################################################################
# Dashboard Outputs
################################################################################

output "id" {
  description = "The ID of the Dashboard."
  value       = var.create ? azurerm_portal_dashboard.this[0].id : null
}

output "name" {
  description = "The name of the Dashboard."
  value       = var.create ? azurerm_portal_dashboard.this[0].name : null
}
