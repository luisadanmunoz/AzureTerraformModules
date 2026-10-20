#############################################################################
# OUTPUT STORAGE CONTAINER
#############################################################################
output "id" {
  value = azurerm_storage_container.storage_container.id
}

output "name" {
  value = azurerm_storage_container.storage_container.name
}
