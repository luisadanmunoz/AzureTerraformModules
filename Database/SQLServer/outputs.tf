################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the SQL Server."
  value       = var.create ? azurerm_mssql_server.this[0].id : null
}

output "name" {
  description = "The name of the SQL Server."
  value       = var.create ? azurerm_mssql_server.this[0].name : null
}

output "fully_qualified_domain_name" {
  description = "The fully qualified domain name of the SQL Server."
  value       = var.create ? azurerm_mssql_server.this[0].fully_qualified_domain_name : null
}

output "identity" {
  description = "The identity configuration of the SQL Server."
  value       = var.create && var.identity != null ? azurerm_mssql_server.this[0].identity : null
}

output "principal_id" {
  description = "The principal ID of the system assigned identity (if enabled)."
  value       = var.create && var.identity != null ? try(azurerm_mssql_server.this[0].identity[0].principal_id, null) : null
}

output "restorable_dropped_database_ids" {
  description = "A list of dropped restorable database IDs on the server."
  value       = var.create ? azurerm_mssql_server.this[0].restorable_dropped_database_ids : null
}

output "firewall_rule_ids" {
  description = "Map of firewall rule names to their IDs."
  value       = var.create ? { for k, v in azurerm_mssql_firewall_rule.this : k => v.id } : {}
}

output "virtual_network_rule_ids" {
  description = "Map of virtual network rule names to their IDs."
  value       = var.create ? { for k, v in azurerm_mssql_virtual_network_rule.this : k => v.id } : {}
}
