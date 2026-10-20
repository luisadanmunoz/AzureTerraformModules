#############################################################################
# OUTPUTS IOT HUB ENDPOINT SERVICEBUS QUEUE
#############################################################################
output "id" {
  description = "value of the iot hub endpoint servicebus queue id"
  value       = azurerm_iothub_endpoint_servicebus_queue.iothub_endpoint_servicebus_queue.id
}

output "name" {
  description = "value of the iot hub endpoint servicebus queue name"
  value       = azurerm_iothub_endpoint_servicebus_queue.iothub_endpoint_servicebus_queue.name
}
