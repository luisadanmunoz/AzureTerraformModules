#############################################################################
# OUTPUTS IOT HUB DPS
#############################################################################
output "id" {
  description = "value of the iot hub dps id"
  value       = azurerm_iothub_dps.iothub_dps.id
}

output "name" {
  description = "value of the iot hub dps name"
  value       = azurerm_iothub_dps.iothub_dps.name
}

output "id_scope" {
  description = "value of the iot hub dps id scope"
  value       = azurerm_iothub_dps.iothub_dps.id_scope
}

output "device_provisioning_host_name" {
  description = "value of the iot hub dps device provisioning host name"
  value       = azurerm_iothub_dps.iothub_dps.device_provisioning_host_name
}
