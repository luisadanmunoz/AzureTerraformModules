################################################################################
# Subnet Outputs
################################################################################

output "id" {
  description = "The ID of the Subnet."
  value       = var.create ? azurerm_subnet.this[0].id : null
}

output "name" {
  description = "The name of the Subnet."
  value       = var.create ? azurerm_subnet.this[0].name : null
}

output "resource_group_name" {
  description = "The name of the Resource Group containing the Subnet."
  value       = var.create ? azurerm_subnet.this[0].resource_group_name : null
}

output "virtual_network_name" {
  description = "The name of the Virtual Network containing the Subnet."
  value       = var.create ? azurerm_subnet.this[0].virtual_network_name : null
}

output "address_prefixes" {
  description = "The address prefixes configured for the Subnet."
  value       = var.create ? azurerm_subnet.this[0].address_prefixes : null
}

################################################################################
# Association Outputs
################################################################################

output "nsg_association_id" {
  description = "The ID of the NSG association (if created)."
  value       = local.create_nsg_association ? azurerm_subnet_network_security_group_association.this[0].id : null
}

output "route_table_association_id" {
  description = "The ID of the Route Table association (if created)."
  value       = local.create_route_table_association ? azurerm_subnet_route_table_association.this[0].id : null
}

output "nat_gateway_association_id" {
  description = "The ID of the NAT Gateway association (if created)."
  value       = local.create_nat_gateway_association ? azurerm_subnet_nat_gateway_association.this[0].id : null
}
