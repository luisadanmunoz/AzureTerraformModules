################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Redis Cache."
  value       = var.create ? azurerm_redis_cache.this[0].id : null
}

output "name" {
  description = "The name of the Redis Cache."
  value       = var.create ? azurerm_redis_cache.this[0].name : null
}

output "hostname" {
  description = "The hostname of the Redis Cache."
  value       = var.create ? azurerm_redis_cache.this[0].hostname : null
}

output "ssl_port" {
  description = "The SSL port of the Redis Cache."
  value       = var.create ? azurerm_redis_cache.this[0].ssl_port : null
}

output "port" {
  description = "The non-SSL port of the Redis Cache (if enabled)."
  value       = var.create ? azurerm_redis_cache.this[0].port : null
}

output "primary_access_key" {
  description = "The primary access key for the Redis Cache."
  value       = var.create ? azurerm_redis_cache.this[0].primary_access_key : null
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for the Redis Cache."
  value       = var.create ? azurerm_redis_cache.this[0].secondary_access_key : null
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string for the Redis Cache."
  value       = var.create ? azurerm_redis_cache.this[0].primary_connection_string : null
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The secondary connection string for the Redis Cache."
  value       = var.create ? azurerm_redis_cache.this[0].secondary_connection_string : null
  sensitive   = true
}

output "identity" {
  description = "The identity configuration of the Redis Cache."
  value       = var.create && var.identity != null ? azurerm_redis_cache.this[0].identity : null
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Managed Identity."
  value       = var.create && var.identity != null ? try(azurerm_redis_cache.this[0].identity[0].principal_id, null) : null
}

output "redis_configuration" {
  description = "The Redis configuration of the cache."
  value       = var.create ? azurerm_redis_cache.this[0].redis_configuration : null
  sensitive   = true
}

output "firewall_rule_ids" {
  description = "Map of firewall rule names to their IDs."
  value       = var.create ? { for k, v in azurerm_redis_firewall_rule.this : k => v.id } : {}
}
