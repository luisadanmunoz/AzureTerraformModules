################################################################################
# File Share Outputs
################################################################################

output "id" {
  description = "The ID of the File Share."
  value       = var.create ? azurerm_storage_share.this[0].id : null
}

output "name" {
  description = "The name of the File Share."
  value       = var.create ? azurerm_storage_share.this[0].name : null
}

output "url" {
  description = "The URL of the File Share."
  value       = var.create ? azurerm_storage_share.this[0].url : null
}

output "resource_manager_id" {
  description = "The Resource Manager ID of the File Share."
  value       = var.create ? azurerm_storage_share.this[0].resource_manager_id : null
}
