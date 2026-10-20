#############################################################################
# OUTPUTS IOT HUB ROUTE
#############################################################################
output "id" {
  description = "value of the iot hub route id"
  value       = azurerm_iothub_route.iothub_route.id
}

output "name" {
  description = "value of the iot hub route name"
  value       = azurerm_iothub_route.iothub_route.name
}
