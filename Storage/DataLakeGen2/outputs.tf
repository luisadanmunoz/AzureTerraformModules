################################################################################
# Data Lake Gen2 Filesystem Outputs
################################################################################

output "id" {
  description = "The ID of the Data Lake Gen2 Filesystem."
  value       = var.create ? azurerm_storage_data_lake_gen2_filesystem.this[0].id : null
}

output "name" {
  description = "The name of the Data Lake Gen2 Filesystem."
  value       = var.create ? azurerm_storage_data_lake_gen2_filesystem.this[0].name : null
}

################################################################################
# Path Outputs
################################################################################

output "path_ids" {
  description = "Map of path keys to their resource IDs."
  value       = { for k, v in azurerm_storage_data_lake_gen2_path.this : k => v.id }
}
