#############################################################################
# OUTPUT STORAGE TABLE
#############################################################################
output "id" {
  value = azurerm_storage_table.storage_table.id
}

output "name" {
  value = azurerm_storage_table.storage_table.name
}
