################################################################################
# Azure IoT Hub Consumer Group
################################################################################

resource "azurerm_iothub_consumer_group" "this" {
  count = var.create ? 1 : 0

  name                   = var.name
  iothub_name            = var.iothub_name
  eventhub_endpoint_name = var.eventhub_endpoint_name
  resource_group_name    = var.resource_group_name
}
