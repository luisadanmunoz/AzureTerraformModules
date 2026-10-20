#############################################################################
# OUTPUT STORAGE QUEUE
#############################################################################
output "id" {
  value = azurerm_storage_queue.storage_queue.id
}

output "name" {
  value = azurerm_storage_queue.storage_queue.name
}

output "url" {
  value = azurerm_storage_queue.storage_queue.url
}
