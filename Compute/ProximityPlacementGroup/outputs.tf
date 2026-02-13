################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Proximity Placement Group."
  value       = var.create ? azurerm_proximity_placement_group.this[0].id : null
}

output "name" {
  description = "The name of the Proximity Placement Group."
  value       = var.create ? azurerm_proximity_placement_group.this[0].name : null
}
