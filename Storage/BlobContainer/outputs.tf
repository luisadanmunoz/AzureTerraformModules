################################################################################
# Blob Container Outputs
################################################################################

output "id" {
  description = "The ID of the Blob Container."
  value       = var.create ? azurerm_storage_container.this[0].id : null
}

output "name" {
  description = "The name of the Blob Container."
  value       = var.create ? azurerm_storage_container.this[0].name : null
}

output "has_immutability_policy" {
  description = "Whether the Blob Container has an immutability policy configured."
  value       = var.create ? azurerm_storage_container.this[0].has_immutability_policy : null
}

output "has_legal_hold" {
  description = "Whether the Blob Container has a legal hold configured."
  value       = var.create ? azurerm_storage_container.this[0].has_legal_hold : null
}

output "resource_manager_id" {
  description = "The Resource Manager ID of the Blob Container."
  value       = var.create ? azurerm_storage_container.this[0].resource_manager_id : null
}
