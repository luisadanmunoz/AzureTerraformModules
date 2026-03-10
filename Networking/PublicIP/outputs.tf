################################################################################
# Public IP Outputs
################################################################################

output "id" {
  description = "The ID of the Public IP."
  value       = var.create ? azurerm_public_ip.this[0].id : null
}

output "name" {
  description = "The name of the Public IP."
  value       = var.create ? azurerm_public_ip.this[0].name : null
}

output "resource_group_name" {
  description = "The name of the Resource Group containing the Public IP."
  value       = var.create ? azurerm_public_ip.this[0].resource_group_name : null
}

output "location" {
  description = "The Azure region where the Public IP is deployed."
  value       = var.create ? azurerm_public_ip.this[0].location : null
}

output "ip_address" {
  description = "The IP address value that was allocated."
  value       = var.create ? azurerm_public_ip.this[0].ip_address : null
}

output "fqdn" {
  description = "The fully qualified domain name (if domain_name_label was set)."
  value       = var.create ? azurerm_public_ip.this[0].fqdn : null
}

output "sku" {
  description = "The SKU of the Public IP."
  value       = var.create ? azurerm_public_ip.this[0].sku : null
}

output "zones" {
  description = "The availability zones configured for the Public IP."
  value       = var.create ? azurerm_public_ip.this[0].zones : null
}

output "diagnostic_settings_id" {
  description = "The ID of the diagnostic settings (if created)."
  value       = local.create_diagnostic_settings ? azurerm_monitor_diagnostic_setting.this[0].id : null
}
