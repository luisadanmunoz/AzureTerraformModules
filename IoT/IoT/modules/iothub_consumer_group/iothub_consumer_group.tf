#############################################################################
# IOT HUB CONSUMER GROUP
#############################################################################
resource "azurerm_iothub_consumer_group" "iothub_consumer_group" {
  name                   = var.iothub_consumer_group_name
  iothub_name            = var.iothub_name
  eventhub_endpoint_name = var.eventhub_endpoint_name
  resource_group_name    = var.resource_group_name

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
