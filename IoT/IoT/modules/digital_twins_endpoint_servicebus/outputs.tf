#############################################################################
# OUTPUTS DIGITAL TWINS ENDPOINT SERVICEBUS
#############################################################################
output "id" {
  description = "value of the digital twins endpoint servicebus id"
  value       = azurerm_digital_twins_endpoint_servicebus.digital_twins_endpoint_servicebus.id
}

output "name" {
  description = "value of the digital twins endpoint servicebus name"
  value       = azurerm_digital_twins_endpoint_servicebus.digital_twins_endpoint_servicebus.name
}
