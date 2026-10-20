#############################################################################
# OUTPUTS IOT HUB ENDPOINT STORAGE CONTAINER
#############################################################################
output "id" {
  description = "value of the iot hub endpoint storage container id"
  value       = azurerm_iothub_endpoint_storage_container.iothub_endpoint_storage_container.id
}

output "name" {
  description = "value of the iot hub endpoint storage container name"
  value       = azurerm_iothub_endpoint_storage_container.iothub_endpoint_storage_container.name
}
