################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Container App."
  value       = var.create ? azurerm_container_app.this[0].id : null
}

output "name" {
  description = "The name of the Container App."
  value       = var.create ? azurerm_container_app.this[0].name : null
}

output "latest_revision_name" {
  description = "The name of the latest revision."
  value       = var.create ? azurerm_container_app.this[0].latest_revision_name : null
}

output "latest_revision_fqdn" {
  description = "The FQDN of the latest revision."
  value       = var.create ? azurerm_container_app.this[0].latest_revision_fqdn : null
}

output "outbound_ip_addresses" {
  description = "List of outbound IP addresses."
  value       = var.create ? azurerm_container_app.this[0].outbound_ip_addresses : null
}

output "custom_domain_verification_id" {
  description = "The verification ID for custom domains."
  value       = var.create ? azurerm_container_app.this[0].custom_domain_verification_id : null
  sensitive   = true
}

output "identity" {
  description = "The identity configuration of the Container App."
  value       = var.create && var.identity != null ? azurerm_container_app.this[0].identity : null
}

output "principal_id" {
  description = "The principal ID of the system assigned identity (if enabled)."
  value       = var.create && var.identity != null ? try(azurerm_container_app.this[0].identity[0].principal_id, null) : null
}
