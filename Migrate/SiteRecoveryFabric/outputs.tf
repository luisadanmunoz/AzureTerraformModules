################################################################################
# Site Recovery Fabric Outputs
################################################################################

output "id" {
  description = "The ID of the Site Recovery Fabric."
  value       = var.create ? azurerm_site_recovery_fabric.this[0].id : null
}

output "name" {
  description = "The name of the Site Recovery Fabric."
  value       = var.create ? azurerm_site_recovery_fabric.this[0].name : null
}
