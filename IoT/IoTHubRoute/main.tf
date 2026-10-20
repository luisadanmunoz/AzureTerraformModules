################################################################################
# Azure IoT Hub Route
################################################################################

resource "azurerm_iothub_route" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  iothub_name         = var.iothub_name
  resource_group_name = var.resource_group_name
  source              = var.source_type
  condition           = var.condition
  endpoint_names      = var.endpoint_names
  enabled             = var.enabled
}
