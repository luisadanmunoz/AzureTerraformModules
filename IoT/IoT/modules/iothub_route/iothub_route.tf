#############################################################################
# IOT HUB ROUTE
#############################################################################
resource "azurerm_iothub_route" "iothub_route" {
  name                = var.iothub_route_name
  resource_group_name = var.resource_group_name
  iothub_name         = var.iothub_name
  source              = var.route_source
  endpoint_names      = var.endpoint_names
  enabled             = var.enabled
  condition           = var.condition

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
