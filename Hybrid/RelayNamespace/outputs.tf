################################################################################
# Relay Namespace Outputs
################################################################################

output "id" {
  description = "The ID of the Relay Namespace."
  value       = var.create ? azurerm_relay_namespace.this[0].id : null
}

output "name" {
  description = "The name of the Relay Namespace."
  value       = var.create ? azurerm_relay_namespace.this[0].name : null
}

output "primary_connection_string" {
  description = "The primary connection string."
  value       = var.create ? azurerm_relay_namespace.this[0].primary_connection_string : null
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The secondary connection string."
  value       = var.create ? azurerm_relay_namespace.this[0].secondary_connection_string : null
  sensitive   = true
}

output "primary_key" {
  description = "The primary access key."
  value       = var.create ? azurerm_relay_namespace.this[0].primary_key : null
  sensitive   = true
}

output "secondary_key" {
  description = "The secondary access key."
  value       = var.create ? azurerm_relay_namespace.this[0].secondary_key : null
  sensitive   = true
}

output "metric_id" {
  description = "The metric ID for monitoring."
  value       = var.create ? azurerm_relay_namespace.this[0].metric_id : null
}
