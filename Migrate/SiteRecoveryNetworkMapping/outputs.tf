################################################################################
# Site Recovery Network Mapping Outputs
################################################################################

output "id" {
  description = "The ID of the Network Mapping."
  value       = var.create ? azurerm_site_recovery_network_mapping.this[0].id : null
}

output "name" {
  description = "The name of the Network Mapping."
  value       = var.create ? azurerm_site_recovery_network_mapping.this[0].name : null
}
