#############################################################################
# OUTPUT NETWORK WATCHER
#############################################################################
output "id" {
  value = azurerm_network_watcher.network_watcher.id
}

output "name" {
  value = azurerm_network_watcher.network_watcher.name
}
