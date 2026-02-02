################################################################################
# Virtual Network Outputs
################################################################################

output "id" {
  description = "The ID of the Virtual Network."
  value       = var.create ? azurerm_virtual_network.this[0].id : null
}

output "name" {
  description = "The name of the Virtual Network."
  value       = var.create ? azurerm_virtual_network.this[0].name : null
}

output "resource_group_name" {
  description = "The name of the Resource Group containing the Virtual Network."
  value       = var.create ? azurerm_virtual_network.this[0].resource_group_name : null
}

output "location" {
  description = "The Azure region where the Virtual Network is deployed."
  value       = var.create ? azurerm_virtual_network.this[0].location : null
}

output "address_space" {
  description = "The list of address spaces used by the Virtual Network."
  value       = var.create ? azurerm_virtual_network.this[0].address_space : null
}

output "dns_servers" {
  description = "The list of DNS servers configured for the Virtual Network."
  value       = var.create ? azurerm_virtual_network.this[0].dns_servers : null
}

output "guid" {
  description = "The GUID of the Virtual Network."
  value       = var.create ? azurerm_virtual_network.this[0].guid : null
}

################################################################################
# Inline Subnet Outputs
################################################################################

output "subnet_ids" {
  description = "Map of subnet names to their IDs."
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "subnet_address_prefixes" {
  description = "Map of subnet names to their address prefixes."
  value       = { for k, v in azurerm_subnet.this : k => v.address_prefixes }
}

output "subnets" {
  description = "Map of all subnet attributes."
  value = { for k, v in azurerm_subnet.this : k => {
    id               = v.id
    name             = v.name
    address_prefixes = v.address_prefixes
  } }
}

################################################################################
# Diagnostic Settings Outputs
################################################################################

output "diagnostic_settings_id" {
  description = "The ID of the diagnostic settings (if created)."
  value       = local.create_diagnostic_settings ? azurerm_monitor_diagnostic_setting.this[0].id : null
}
