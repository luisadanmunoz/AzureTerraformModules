################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Container Registry."
  value       = var.create ? azurerm_container_registry.this[0].id : null
}

output "name" {
  description = "The name of the Container Registry."
  value       = var.create ? azurerm_container_registry.this[0].name : null
}

output "login_server" {
  description = "The URL that can be used to log into the Container Registry."
  value       = var.create ? azurerm_container_registry.this[0].login_server : null
}

output "admin_username" {
  description = "The admin username of the Container Registry (if admin is enabled)."
  value       = var.create && var.admin_enabled ? azurerm_container_registry.this[0].admin_username : null
  sensitive   = true
}

output "admin_password" {
  description = "The admin password of the Container Registry (if admin is enabled)."
  value       = var.create && var.admin_enabled ? azurerm_container_registry.this[0].admin_password : null
  sensitive   = true
}

output "identity" {
  description = "The identity configuration of the Container Registry."
  value       = var.create && var.identity != null ? azurerm_container_registry.this[0].identity : null
}

output "principal_id" {
  description = "The principal ID of the system assigned identity (if enabled)."
  value       = var.create && var.identity != null ? try(azurerm_container_registry.this[0].identity[0].principal_id, null) : null
}

output "webhook_ids" {
  description = "Map of webhook names to their IDs."
  value       = var.create ? { for k, v in azurerm_container_registry_webhook.this : k => v.id } : {}
}

output "scope_map_ids" {
  description = "Map of scope map names to their IDs."
  value       = var.create ? { for k, v in azurerm_container_registry_scope_map.this : k => v.id } : {}
}
