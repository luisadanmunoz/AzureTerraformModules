################################################################################
# Storage Account Outputs
################################################################################

output "id" {
  description = "The ID of the Storage Account."
  value       = var.create ? azurerm_storage_account.this[0].id : null
}

output "name" {
  description = "The name of the Storage Account."
  value       = var.create ? azurerm_storage_account.this[0].name : null
}

output "primary_access_key" {
  description = "The primary access key for the Storage Account."
  value       = var.create ? azurerm_storage_account.this[0].primary_access_key : null
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string for the Storage Account."
  value       = var.create ? azurerm_storage_account.this[0].primary_connection_string : null
  sensitive   = true
}

output "primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = var.create ? azurerm_storage_account.this[0].primary_blob_endpoint : null
}

output "primary_blob_host" {
  description = "The hostname with port for blob storage in the primary location."
  value       = var.create ? azurerm_storage_account.this[0].primary_blob_host : null
}

output "primary_file_endpoint" {
  description = "The endpoint URL for file storage in the primary location."
  value       = var.create ? azurerm_storage_account.this[0].primary_file_endpoint : null
}

output "primary_queue_endpoint" {
  description = "The endpoint URL for queue storage in the primary location."
  value       = var.create ? azurerm_storage_account.this[0].primary_queue_endpoint : null
}

output "primary_table_endpoint" {
  description = "The endpoint URL for table storage in the primary location."
  value       = var.create ? azurerm_storage_account.this[0].primary_table_endpoint : null
}

output "primary_dfs_endpoint" {
  description = "The endpoint URL for DFS storage in the primary location (Data Lake)."
  value       = var.create ? azurerm_storage_account.this[0].primary_dfs_endpoint : null
}

output "identity" {
  description = "The managed identity block of the Storage Account, containing principal_id and tenant_id."
  value = var.create && length(azurerm_storage_account.this[0].identity) > 0 ? {
    principal_id = azurerm_storage_account.this[0].identity[0].principal_id
    tenant_id    = azurerm_storage_account.this[0].identity[0].tenant_id
  } : null
}

################################################################################
# Diagnostic Settings Outputs
################################################################################

output "diagnostic_settings_id" {
  description = "The ID of the diagnostic settings (if created)."
  value       = local.create_diagnostic_settings ? azurerm_monitor_diagnostic_setting.this[0].id : null
}
