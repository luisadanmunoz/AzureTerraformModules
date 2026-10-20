################################################################################
# Hybrid Connection Outputs
################################################################################

output "id" {
  description = "The ID of the Hybrid Connection."
  value       = var.create ? azurerm_relay_hybrid_connection.this[0].id : null
}

output "name" {
  description = "The name of the Hybrid Connection."
  value       = var.create ? azurerm_relay_hybrid_connection.this[0].name : null
}
