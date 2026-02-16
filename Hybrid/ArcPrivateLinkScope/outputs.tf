################################################################################
# Arc Private Link Scope Outputs
################################################################################

output "id" {
  description = "The ID of the Arc Private Link Scope."
  value       = var.create ? azurerm_arc_private_link_scope.this[0].id : null
}

output "name" {
  description = "The name of the Arc Private Link Scope."
  value       = var.create ? azurerm_arc_private_link_scope.this[0].name : null
}

output "resource_group_name" {
  description = "The resource group name."
  value       = var.create ? azurerm_arc_private_link_scope.this[0].resource_group_name : null
}

output "location" {
  description = "The Azure region."
  value       = var.create ? azurerm_arc_private_link_scope.this[0].location : null
}
