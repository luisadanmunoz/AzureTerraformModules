#############################################################################
# IOT HUB CERTIFICATE
#############################################################################
resource "azurerm_iothub_certificate" "iothub_certificate" {
  name                = var.iothub_certificate_name
  resource_group_name = var.resource_group_name
  iothub_name         = var.iothub_name
  certificate_content = var.certificate_content
  is_verified         = var.is_verified

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
