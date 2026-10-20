#############################################################################
# OUTPUTS IOT HUB ENDPOINT EVENTHUB
#############################################################################
output "id" {
  description = "value of the iot hub endpoint eventhub id"
  value       = azurerm_iothub_endpoint_eventhub.iothub_endpoint_eventhub.id
}

output "name" {
  description = "value of the iot hub endpoint eventhub name"
  value       = azurerm_iothub_endpoint_eventhub.iothub_endpoint_eventhub.name
}
