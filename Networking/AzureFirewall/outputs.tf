################################################################################
# Azure Firewall Outputs
################################################################################

output "id" {
  description = "The ID of the Azure Firewall."
  value       = var.create ? azurerm_firewall.this[0].id : null
}

output "name" {
  description = "The name of the Azure Firewall."
  value       = var.create ? azurerm_firewall.this[0].name : null
}

output "resource_group_name" {
  description = "The name of the Resource Group."
  value       = var.create ? azurerm_firewall.this[0].resource_group_name : null
}

output "private_ip_address" {
  description = "The private IP address of the Azure Firewall."
  value       = var.create && var.sku_name == "AZFW_VNet" ? azurerm_firewall.this[0].ip_configuration[0].private_ip_address : null
}

output "public_ip_addresses" {
  description = "List of public IP addresses associated with the firewall."
  value = var.create && var.sku_name == "AZFW_VNet" ? [
    for ip_config in azurerm_firewall.this[0].ip_configuration : ip_config.public_ip_address_id
  ] : null
}

output "virtual_hub_private_ip_address" {
  description = "The private IP address in Virtual Hub (Hub deployment only)."
  value       = var.create && var.sku_name == "AZFW_Hub" && length(azurerm_firewall.this[0].virtual_hub) > 0 ? azurerm_firewall.this[0].virtual_hub[0].private_ip_address : null
}

output "virtual_hub_public_ip_addresses" {
  description = "List of public IP addresses in Virtual Hub (Hub deployment only)."
  value       = var.create && var.sku_name == "AZFW_Hub" && length(azurerm_firewall.this[0].virtual_hub) > 0 ? azurerm_firewall.this[0].virtual_hub[0].public_ip_addresses : null
}

################################################################################
# Public IP Outputs (if created)
################################################################################

output "created_public_ip_ids" {
  description = "IDs of Public IPs created by this module."
  value       = local.create_public_ips ? [for pip in azurerm_public_ip.this : pip.id] : []
}

output "created_public_ip_addresses" {
  description = "IP addresses of Public IPs created by this module."
  value       = local.create_public_ips ? [for pip in azurerm_public_ip.this : pip.ip_address] : []
}

################################################################################
# Diagnostic Settings Output
################################################################################

output "diagnostic_settings_id" {
  description = "The ID of the diagnostic settings (if created)."
  value       = local.create_diagnostic_settings ? azurerm_monitor_diagnostic_setting.this[0].id : null
}
