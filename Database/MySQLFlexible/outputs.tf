################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the MySQL Flexible Server."
  value       = var.create ? azurerm_mysql_flexible_server.this[0].id : null
}

output "name" {
  description = "The name of the MySQL Flexible Server."
  value       = var.create ? azurerm_mysql_flexible_server.this[0].name : null
}

output "fqdn" {
  description = "The FQDN of the MySQL Flexible Server."
  value       = var.create ? azurerm_mysql_flexible_server.this[0].fqdn : null
}

output "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  value       = var.create ? azurerm_mysql_flexible_server.this[0].public_network_access_enabled : null
}

output "replica_capacity" {
  description = "The maximum number of replicas that a primary MySQL Flexible Server can have."
  value       = var.create ? azurerm_mysql_flexible_server.this[0].replica_capacity : null
}

output "identity" {
  description = "The identity configuration of the MySQL Flexible Server."
  value       = var.create && var.identity != null ? azurerm_mysql_flexible_server.this[0].identity : null
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Managed Identity."
  value       = var.create && var.identity != null ? try(azurerm_mysql_flexible_server.this[0].identity[0].principal_id, null) : null
}

output "database_ids" {
  description = "Map of database names to their IDs."
  value       = var.create ? { for k, v in azurerm_mysql_flexible_database.this : k => v.id } : {}
}

output "firewall_rule_ids" {
  description = "Map of firewall rule names to their IDs."
  value       = var.create ? { for k, v in azurerm_mysql_flexible_server_firewall_rule.this : k => v.id } : {}
}
