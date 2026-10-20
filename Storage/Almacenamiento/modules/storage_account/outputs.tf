#############################################################################
# OUTPUT STORAGE ACCOUNT
#############################################################################
output "id" {
  value = azurerm_storage_account.storage_account.id
}

output "name" {
  value = azurerm_storage_account.storage_account.name
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "primary_file_endpoint" {
  value = azurerm_storage_account.storage_account.primary_file_endpoint
}

output "primary_dfs_endpoint" {
  value = azurerm_storage_account.storage_account.primary_dfs_endpoint
}
