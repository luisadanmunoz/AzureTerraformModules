#############################################################################
# OUTPUTS IOT HUB
#############################################################################
output "id" {
  description = "value of the iot hub id"
  value       = azurerm_iothub.iothub.id
}

output "name" {
  description = "value of the iot hub name"
  value       = azurerm_iothub.iothub.name
}

output "hostname" {
  description = "value of the iot hub hostname"
  value       = azurerm_iothub.iothub.hostname
}

output "event_hub_events_endpoint" {
  description = "value of the iot hub event hub events endpoint"
  value       = azurerm_iothub.iothub.event_hub_events_endpoint
}

output "type" {
  description = "value of the iot hub type"
  value       = azurerm_iothub.iothub.type
}
