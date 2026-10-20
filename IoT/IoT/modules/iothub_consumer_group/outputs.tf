#############################################################################
# OUTPUTS IOT HUB CONSUMER GROUP
#############################################################################
output "id" {
  description = "value of the iot hub consumer group id"
  value       = azurerm_iothub_consumer_group.iothub_consumer_group.id
}

output "name" {
  description = "value of the iot hub consumer group name"
  value       = azurerm_iothub_consumer_group.iothub_consumer_group.name
}
