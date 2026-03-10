################################################################################
# Azure IoT Hub Shared Access Policy
################################################################################

resource "azurerm_iothub_shared_access_policy" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  iothub_name         = var.iothub_name
  resource_group_name = var.resource_group_name

  registry_read   = var.registry_read
  registry_write  = var.registry_write
  service_connect = var.service_connect
  device_connect  = var.device_connect
}
