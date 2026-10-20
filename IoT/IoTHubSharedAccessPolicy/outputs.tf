################################################################################
# IoT Hub Shared Access Policy Outputs
################################################################################

output "id" {
  description = "The ID of the IoT Hub Shared Access Policy."
  value       = var.create ? azurerm_iothub_shared_access_policy.this[0].id : null
}

output "name" {
  description = "The name of the IoT Hub Shared Access Policy."
  value       = var.create ? azurerm_iothub_shared_access_policy.this[0].name : null
}

output "primary_key" {
  description = "The primary key of the Shared Access Policy."
  value       = var.create ? azurerm_iothub_shared_access_policy.this[0].primary_key : null
  sensitive   = true
}

output "secondary_key" {
  description = "The secondary key of the Shared Access Policy."
  value       = var.create ? azurerm_iothub_shared_access_policy.this[0].secondary_key : null
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string of the Shared Access Policy."
  value       = var.create ? azurerm_iothub_shared_access_policy.this[0].primary_connection_string : null
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The secondary connection string of the Shared Access Policy."
  value       = var.create ? azurerm_iothub_shared_access_policy.this[0].secondary_connection_string : null
  sensitive   = true
}
