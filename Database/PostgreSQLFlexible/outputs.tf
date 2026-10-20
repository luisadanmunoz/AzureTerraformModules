################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the PostgreSQL Flexible Server."
  value       = var.create ? azurerm_postgresql_flexible_server.this[0].id : null
}

output "name" {
  description = "The name of the PostgreSQL Flexible Server."
  value       = var.create ? azurerm_postgresql_flexible_server.this[0].name : null
}

output "fqdn" {
  description = "The fully qualified domain name of the PostgreSQL Flexible Server."
  value       = var.create ? azurerm_postgresql_flexible_server.this[0].fqdn : null
}

output "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  value       = var.create ? azurerm_postgresql_flexible_server.this[0].public_network_access_enabled : null
}

output "administrator_login" {
  description = "The administrator login name."
  value       = var.create ? azurerm_postgresql_flexible_server.this[0].administrator_login : null
  sensitive   = true
}

output "identity" {
  description = "The identity configuration of the server."
  value       = var.create && var.identity != null ? azurerm_postgresql_flexible_server.this[0].identity : null
}

output "database_ids" {
  description = "Map of database names to their IDs."
  value       = var.create ? { for k, v in azurerm_postgresql_flexible_server_database.this : k => v.id } : {}
}

output "firewall_rule_ids" {
  description = "Map of firewall rule names to their IDs."
  value       = var.create ? { for k, v in azurerm_postgresql_flexible_server_firewall_rule.this : k => v.id } : {}
}
