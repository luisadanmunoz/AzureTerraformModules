#############################################################################
# IOT HUB FALLBACK ROUTE
#############################################################################
resource "azurerm_iothub_fallback_route" "iothub_fallback_route" {
  resource_group_name = var.resource_group_name
  iothub_name         = var.iothub_name
  enabled             = var.enabled
  endpoint_names      = var.endpoint_names
  source              = var.fallback_route_source
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
