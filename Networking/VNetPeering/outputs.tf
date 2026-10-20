################################################################################
# VNet Peering Outputs
################################################################################

output "id" {
  description = "The ID of the VNet Peering."
  value       = var.create ? azurerm_virtual_network_peering.this[0].id : null
}

output "name" {
  description = "The name of the VNet Peering."
  value       = var.create ? azurerm_virtual_network_peering.this[0].name : null
}

output "virtual_network_name" {
  description = "The name of the local Virtual Network."
  value       = var.create ? azurerm_virtual_network_peering.this[0].virtual_network_name : null
}

output "remote_virtual_network_id" {
  description = "The ID of the remote Virtual Network."
  value       = var.create ? azurerm_virtual_network_peering.this[0].remote_virtual_network_id : null
}

################################################################################
# Reverse Peering Outputs
################################################################################

output "reverse_peering_id" {
  description = "The ID of the reverse VNet Peering (if created)."
  value       = var.create && var.create_reverse_peering ? azurerm_virtual_network_peering.reverse[0].id : null
}

output "reverse_peering_name" {
  description = "The name of the reverse VNet Peering (if created)."
  value       = var.create && var.create_reverse_peering ? azurerm_virtual_network_peering.reverse[0].name : null
}
