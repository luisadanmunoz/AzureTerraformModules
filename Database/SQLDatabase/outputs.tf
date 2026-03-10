################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the SQL Database."
  value       = var.create ? azurerm_mssql_database.this[0].id : null
}

output "name" {
  description = "The name of the SQL Database."
  value       = var.create ? azurerm_mssql_database.this[0].name : null
}

output "server_id" {
  description = "The ID of the SQL Server hosting this database."
  value       = var.server_id
}

output "sku_name" {
  description = "The SKU name of the database."
  value       = var.create ? azurerm_mssql_database.this[0].sku_name : null
}

output "max_size_gb" {
  description = "The maximum size of the database in GB."
  value       = var.create ? azurerm_mssql_database.this[0].max_size_gb : null
}

output "zone_redundant" {
  description = "Whether the database is zone redundant."
  value       = var.create ? azurerm_mssql_database.this[0].zone_redundant : null
}

output "identity" {
  description = "The identity configuration of the database."
  value       = var.create && var.identity != null ? azurerm_mssql_database.this[0].identity : null
}
