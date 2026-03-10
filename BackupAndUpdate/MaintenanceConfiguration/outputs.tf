################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Maintenance Configuration."
  value       = var.create ? azurerm_maintenance_configuration.this[0].id : null
}

output "name" {
  description = "The name of the Maintenance Configuration."
  value       = var.create ? azurerm_maintenance_configuration.this[0].name : null
}

output "scope" {
  description = "The scope of the Maintenance Configuration."
  value       = var.create ? azurerm_maintenance_configuration.this[0].scope : null
}

output "location" {
  description = "The location of the Maintenance Configuration."
  value       = var.create ? azurerm_maintenance_configuration.this[0].location : null
}
