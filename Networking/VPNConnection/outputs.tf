################################################################################
# VPN Connection Outputs
################################################################################

output "id" {
  description = "The ID of the VPN Connection."
  value       = var.create ? azurerm_virtual_network_gateway_connection.this[0].id : null
}

output "name" {
  description = "The name of the VPN Connection."
  value       = var.create ? azurerm_virtual_network_gateway_connection.this[0].name : null
}
