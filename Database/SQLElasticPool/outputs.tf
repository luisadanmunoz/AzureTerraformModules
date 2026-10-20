################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the elastic pool."
  value       = var.create ? azurerm_mssql_elasticpool.this[0].id : null
}

output "name" {
  description = "The name of the elastic pool."
  value       = var.create ? azurerm_mssql_elasticpool.this[0].name : null
}

output "sku_name" {
  description = "The SKU name of the elastic pool."
  value       = var.create ? var.sku.name : null
}

output "max_size_gb" {
  description = "The maximum size of the elastic pool in GB."
  value       = var.create ? azurerm_mssql_elasticpool.this[0].max_size_gb : null
}

output "zone_redundant" {
  description = "Whether the elastic pool is zone redundant."
  value       = var.create ? azurerm_mssql_elasticpool.this[0].zone_redundant : null
}

output "per_database_settings" {
  description = "The per-database settings of the elastic pool."
  value = var.create ? {
    min_capacity = var.per_database_settings.min_capacity
    max_capacity = var.per_database_settings.max_capacity
  } : null
}
