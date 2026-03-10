################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the AVD Workspace."
  value       = try(azurerm_virtual_desktop_workspace.this[0].id, null)
}

output "name" {
  description = "The name of the AVD Workspace."
  value       = try(azurerm_virtual_desktop_workspace.this[0].name, null)
}

output "friendly_name" {
  description = "The friendly name of the Workspace."
  value       = try(azurerm_virtual_desktop_workspace.this[0].friendly_name, null)
}

output "associated_application_group_ids" {
  description = "The list of Application Group IDs associated with this Workspace."
  value       = [for assoc in azurerm_virtual_desktop_workspace_application_group_association.this : assoc.application_group_id]
}
