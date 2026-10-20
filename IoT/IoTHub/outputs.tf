################################################################################
# IoT Hub Outputs
################################################################################

output "id" {
  description = "The ID of the IoT Hub."
  value       = var.create ? azurerm_iothub.this[0].id : null
}

output "name" {
  description = "The name of the IoT Hub."
  value       = var.create ? azurerm_iothub.this[0].name : null
}

output "hostname" {
  description = "The hostname of the IoT Hub."
  value       = var.create ? azurerm_iothub.this[0].hostname : null
}

output "type" {
  description = "The type of the IoT Hub."
  value       = var.create ? azurerm_iothub.this[0].type : null
}

################################################################################
# Event Hub Compatible Endpoint Outputs
################################################################################

output "event_hub_events_endpoint" {
  description = "The Event Hub-compatible endpoint."
  value       = var.create ? azurerm_iothub.this[0].event_hub_events_endpoint : null
}

output "event_hub_events_namespace" {
  description = "The Event Hub-compatible namespace."
  value       = var.create ? azurerm_iothub.this[0].event_hub_events_namespace : null
}

output "event_hub_events_path" {
  description = "The Event Hub-compatible path."
  value       = var.create ? azurerm_iothub.this[0].event_hub_events_path : null
}

output "event_hub_operations_endpoint" {
  description = "The Event Hub-compatible operations endpoint."
  value       = var.create ? azurerm_iothub.this[0].event_hub_operations_endpoint : null
}

output "event_hub_operations_path" {
  description = "The Event Hub-compatible operations path."
  value       = var.create ? azurerm_iothub.this[0].event_hub_operations_path : null
}

################################################################################
# Identity Outputs
################################################################################

output "principal_id" {
  description = "The principal ID of the system-assigned managed identity."
  value       = var.create ? try(azurerm_iothub.this[0].identity[0].principal_id, null) : null
}

output "tenant_id" {
  description = "The tenant ID of the system-assigned managed identity."
  value       = var.create ? try(azurerm_iothub.this[0].identity[0].tenant_id, null) : null
}

################################################################################
# Shared Access Policy Outputs
################################################################################

output "shared_access_policy" {
  description = "The shared access policies of the IoT Hub."
  value       = var.create ? azurerm_iothub.this[0].shared_access_policy : null
  sensitive   = true
}
