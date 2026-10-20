################################################################################
# IoT Hub Route Outputs
################################################################################

output "id" {
  description = "The ID of the IoT Hub Route."
  value       = var.create ? azurerm_iothub_route.this[0].id : null
}

output "name" {
  description = "The name of the IoT Hub Route."
  value       = var.create ? azurerm_iothub_route.this[0].name : null
}

output "source" {
  description = "The source of the IoT Hub Route."
  value       = var.create ? azurerm_iothub_route.this[0].source : null
}

output "condition" {
  description = "The condition of the IoT Hub Route."
  value       = var.create ? azurerm_iothub_route.this[0].condition : null
}

output "endpoint_names" {
  description = "The endpoint names of the IoT Hub Route."
  value       = var.create ? azurerm_iothub_route.this[0].endpoint_names : null
}

output "enabled" {
  description = "Whether the IoT Hub Route is enabled."
  value       = var.create ? azurerm_iothub_route.this[0].enabled : null
}
