################################################################################
# Route Table Outputs
################################################################################

output "id" {
  description = "The ID of the Route Table."
  value       = var.create ? azurerm_route_table.this[0].id : null
}

output "name" {
  description = "The name of the Route Table."
  value       = var.create ? azurerm_route_table.this[0].name : null
}

output "resource_group_name" {
  description = "The name of the Resource Group."
  value       = var.create ? azurerm_route_table.this[0].resource_group_name : null
}

output "location" {
  description = "The Azure region."
  value       = var.create ? azurerm_route_table.this[0].location : null
}

output "route_ids" {
  description = "Map of route names to their IDs."
  value       = { for k, v in azurerm_route.this : k => v.id }
}

output "routes" {
  description = "Map of route configurations."
  value = { for k, v in azurerm_route.this : k => {
    id                     = v.id
    name                   = v.name
    address_prefix         = v.address_prefix
    next_hop_type          = v.next_hop_type
    next_hop_in_ip_address = v.next_hop_in_ip_address
  } }
}
