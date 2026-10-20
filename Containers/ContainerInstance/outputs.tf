################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Container Group."
  value       = var.create ? azurerm_container_group.this[0].id : null
}

output "name" {
  description = "The name of the Container Group."
  value       = var.create ? azurerm_container_group.this[0].name : null
}

output "ip_address" {
  description = "The IP address of the Container Group."
  value       = var.create ? azurerm_container_group.this[0].ip_address : null
}

output "fqdn" {
  description = "The FQDN of the Container Group (if public IP with DNS label)."
  value       = var.create ? azurerm_container_group.this[0].fqdn : null
}

output "identity" {
  description = "The identity configuration of the Container Group."
  value       = var.create && var.identity != null ? azurerm_container_group.this[0].identity : null
}

output "principal_id" {
  description = "The principal ID of the system assigned identity (if enabled)."
  value       = var.create && var.identity != null ? try(azurerm_container_group.this[0].identity[0].principal_id, null) : null
}
