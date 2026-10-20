#############################################################################
# DIGITAL TWINS ENDPOINT SERVICEBUS
#############################################################################
resource "azurerm_digital_twins_endpoint_servicebus" "digital_twins_endpoint_servicebus" {
  name                                   = var.digital_twins_endpoint_servicebus_name
  digital_twins_id                       = var.digital_twins_id
  servicebus_primary_connection_string   = var.servicebus_primary_connection_string
  servicebus_secondary_connection_string = var.servicebus_secondary_connection_string
  dead_letter_storage_secret             = var.dead_letter_storage_secret

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
