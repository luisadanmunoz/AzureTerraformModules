################################################################################
# IoT Hub Consumer Group Outputs
################################################################################

output "id" {
  description = "The ID of the IoT Hub Consumer Group."
  value       = var.create ? azurerm_iothub_consumer_group.this[0].id : null
}

output "name" {
  description = "The name of the IoT Hub Consumer Group."
  value       = var.create ? azurerm_iothub_consumer_group.this[0].name : null
}

output "iothub_name" {
  description = "The name of the IoT Hub."
  value       = var.create ? azurerm_iothub_consumer_group.this[0].iothub_name : null
}

output "eventhub_endpoint_name" {
  description = "The name of the Event Hub-compatible endpoint."
  value       = var.create ? azurerm_iothub_consumer_group.this[0].eventhub_endpoint_name : null
}
