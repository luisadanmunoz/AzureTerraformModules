################################################################################
# Resource Mover Move Collection Outputs
################################################################################

output "id" {
  description = "The ID of the Move Collection."
  value       = var.create ? azurerm_resource_mover_move_collection.this[0].id : null
}

output "name" {
  description = "The name of the Move Collection."
  value       = var.create ? azurerm_resource_mover_move_collection.this[0].name : null
}

output "principal_id" {
  description = "The principal ID of the system-assigned identity."
  value       = var.create ? try(azurerm_resource_mover_move_collection.this[0].identity[0].principal_id, null) : null
}
