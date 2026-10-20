################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the AVD Application Group."
  value       = try(azurerm_virtual_desktop_application_group.this[0].id, null)
}

output "name" {
  description = "The name of the AVD Application Group."
  value       = try(azurerm_virtual_desktop_application_group.this[0].name, null)
}

output "type" {
  description = "The type of the Application Group (Desktop or RemoteApp)."
  value       = try(azurerm_virtual_desktop_application_group.this[0].type, null)
}

output "host_pool_id" {
  description = "The Host Pool ID associated with this Application Group."
  value       = try(azurerm_virtual_desktop_application_group.this[0].host_pool_id, null)
}
