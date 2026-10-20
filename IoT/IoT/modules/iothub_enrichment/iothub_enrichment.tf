#############################################################################
# IOT HUB ENRICHMENT
#############################################################################
resource "azurerm_iothub_enrichment" "iothub_enrichment" {
  resource_group_name = var.resource_group_name
  iothub_name         = var.iothub_name
  key                 = var.key
  value               = var.value
  endpoint_names      = var.endpoint_names

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
