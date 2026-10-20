################################################################################
# Local Network Gateway Outputs
################################################################################

output "id" {
  description = "The ID of the Local Network Gateway."
  value       = var.create ? azurerm_local_network_gateway.this[0].id : null
}

output "name" {
  description = "The name of the Local Network Gateway."
  value       = var.create ? azurerm_local_network_gateway.this[0].name : null
}
