#############################################################################
# OUTPUTS IOT HUB DEVICE UPDATE ACCOUNT
#############################################################################
output "id" {
  description = "value of the iot hub device update account id"
  value       = azurerm_iothub_device_update_account.iothub_device_update_account.id
}

output "name" {
  description = "value of the iot hub device update account name"
  value       = azurerm_iothub_device_update_account.iothub_device_update_account.name
}

output "host_name" {
  description = "value of the iot hub device update account host name"
  value       = azurerm_iothub_device_update_account.iothub_device_update_account.host_name
}
