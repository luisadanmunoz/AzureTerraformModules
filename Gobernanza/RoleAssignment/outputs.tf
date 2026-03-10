################################################################################
# Role Assignment Outputs
################################################################################

output "role_assignment_ids" {
  description = "Map of role assignment keys to their resource IDs."
  value = {
    for key, ra in azurerm_role_assignment.this :
    key => ra.id
  }
}

output "role_assignment_names" {
  description = "Map of role assignment keys to their names (UUIDs)."
  value = {
    for key, ra in azurerm_role_assignment.this :
    key => ra.name
  }
}

output "role_assignment_principal_types" {
  description = "Map of role assignment keys to the resolved principal type."
  value = {
    for key, ra in azurerm_role_assignment.this :
    key => ra.principal_type
  }
}

output "role_assignments" {
  description = "Full map of all role assignment resources."
  value       = azurerm_role_assignment.this
}
