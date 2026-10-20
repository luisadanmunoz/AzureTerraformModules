################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Role Definition."
  value       = var.create ? azurerm_role_definition.this[0].id : null
}

output "role_definition_id" {
  description = "The Role Definition ID (GUID)."
  value       = var.create ? azurerm_role_definition.this[0].role_definition_id : null
}

output "name" {
  description = "The name of the Role Definition."
  value       = var.create ? azurerm_role_definition.this[0].name : null
}

output "role_definition_resource_id" {
  description = "The Resource ID of the Role Definition."
  value       = var.create ? azurerm_role_definition.this[0].role_definition_resource_id : null
}
