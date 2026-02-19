################################################################################
# Site Recovery Protection Container Outputs
################################################################################

output "id" {
  description = "The ID of the Protection Container."
  value       = var.create ? azurerm_site_recovery_protection_container.this[0].id : null
}

output "name" {
  description = "The name of the Protection Container."
  value       = var.create ? azurerm_site_recovery_protection_container.this[0].name : null
}
