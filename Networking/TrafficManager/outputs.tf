################################################################################
# Traffic Manager Profile Outputs
################################################################################

output "id" {
  description = "The ID of the Traffic Manager profile."
  value       = var.create ? azurerm_traffic_manager_profile.this[0].id : null
}

output "name" {
  description = "The name of the Traffic Manager profile."
  value       = var.create ? azurerm_traffic_manager_profile.this[0].name : null
}

output "fqdn" {
  description = "The FQDN of the Traffic Manager profile."
  value       = var.create ? azurerm_traffic_manager_profile.this[0].fqdn : null
}

output "profile_id" {
  description = "The unique profile ID of the Traffic Manager profile."
  value       = var.create ? azurerm_traffic_manager_profile.this[0].id : null
}

output "azure_endpoint_ids" {
  description = "Map of Azure endpoint names to their IDs."
  value       = { for k, v in azurerm_traffic_manager_azure_endpoint.this : k => v.id }
}

output "external_endpoint_ids" {
  description = "Map of external endpoint names to their IDs."
  value       = { for k, v in azurerm_traffic_manager_external_endpoint.this : k => v.id }
}

output "nested_endpoint_ids" {
  description = "Map of nested endpoint names to their IDs."
  value       = { for k, v in azurerm_traffic_manager_nested_endpoint.this : k => v.id }
}
