#############################################################################
# OUTPUTS IOT HUB ENDPOINT SERVICEBUS TOPIC
#############################################################################
output "id" {
  description = "value of the iot hub endpoint servicebus topic id"
  value       = azurerm_iothub_endpoint_servicebus_topic.iothub_endpoint_servicebus_topic.id
}

output "name" {
  description = "value of the iot hub endpoint servicebus topic name"
  value       = azurerm_iothub_endpoint_servicebus_topic.iothub_endpoint_servicebus_topic.name
}
