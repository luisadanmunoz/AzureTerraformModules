################################################################################
# Network Watcher Outputs
################################################################################

output "id" {
  description = "The ID of the Network Watcher."
  value       = var.create ? azurerm_network_watcher.this[0].id : null
}

output "name" {
  description = "The name of the Network Watcher."
  value       = var.create ? azurerm_network_watcher.this[0].name : null
}
