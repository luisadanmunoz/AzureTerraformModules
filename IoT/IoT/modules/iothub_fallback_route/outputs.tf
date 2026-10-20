#############################################################################
# OUTPUTS IOT HUB FALLBACK ROUTE
#############################################################################
output "id" {
  description = "value of the iot hub fallback route id"
  value       = azurerm_iothub_fallback_route.iothub_fallback_route.id
}
