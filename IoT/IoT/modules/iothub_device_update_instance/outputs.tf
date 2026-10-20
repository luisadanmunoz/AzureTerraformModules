#############################################################################
# OUTPUTS IOT HUB DEVICE UPDATE INSTANCE
#############################################################################
output "id" {
  description = "value of the iot hub device update instance id"
  value       = azurerm_iothub_device_update_instance.iothub_device_update_instance.id
}

output "name" {
  description = "value of the iot hub device update instance name"
  value       = azurerm_iothub_device_update_instance.iothub_device_update_instance.name
}
