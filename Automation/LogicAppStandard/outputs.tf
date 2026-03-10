################################################################################
# Logic App Standard Outputs
################################################################################

output "id" {
  description = "The ID of the Logic App Standard."
  value       = var.create ? azurerm_logic_app_standard.this[0].id : null
}

output "name" {
  description = "The name of the Logic App Standard."
  value       = var.create ? azurerm_logic_app_standard.this[0].name : null
}

output "default_hostname" {
  description = "The default hostname of the Logic App Standard."
  value       = var.create ? azurerm_logic_app_standard.this[0].default_hostname : null
}

output "outbound_ip_addresses" {
  description = "Comma-separated list of outbound IP addresses."
  value       = var.create ? azurerm_logic_app_standard.this[0].outbound_ip_addresses : null
}

output "possible_outbound_ip_addresses" {
  description = "Comma-separated list of possible outbound IP addresses."
  value       = var.create ? azurerm_logic_app_standard.this[0].possible_outbound_ip_addresses : null
}

output "site_credential" {
  description = "The site credentials for publishing."
  value       = var.create ? azurerm_logic_app_standard.this[0].site_credential : null
  sensitive   = true
}

output "custom_domain_verification_id" {
  description = "The custom domain verification ID."
  value       = var.create ? azurerm_logic_app_standard.this[0].custom_domain_verification_id : null
}

output "identity" {
  description = "The identity block of the Logic App Standard."
  value       = var.create && var.identity != null ? azurerm_logic_app_standard.this[0].identity : null
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Identity."
  value       = var.create && var.identity != null ? try(azurerm_logic_app_standard.this[0].identity[0].principal_id, null) : null
}

output "tenant_id" {
  description = "The Tenant ID of the System Assigned Identity."
  value       = var.create && var.identity != null ? try(azurerm_logic_app_standard.this[0].identity[0].tenant_id, null) : null
}

output "kind" {
  description = "The kind of the Logic App Standard."
  value       = var.create ? azurerm_logic_app_standard.this[0].kind : null
}
