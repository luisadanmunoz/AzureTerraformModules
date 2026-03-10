################################################################################
# Single Table Outputs
################################################################################

output "id" {
  description = "The ID of the Storage Table (single table mode)."
  value       = var.create && !local.use_multiple_tables ? azurerm_storage_table.single[0].id : null
}

output "name" {
  description = "The name of the Storage Table (single table mode)."
  value       = var.create && !local.use_multiple_tables ? azurerm_storage_table.single[0].name : null
}

################################################################################
# Multiple Tables Outputs
################################################################################

output "table_ids" {
  description = "Map of table names to their IDs (multiple tables mode)."
  value = {
    for name, table in azurerm_storage_table.multiple :
    name => table.id
  }
}

output "table_names" {
  description = "Map of table keys to their names (multiple tables mode)."
  value = {
    for name, table in azurerm_storage_table.multiple :
    name => table.name
  }
}
