#############################################################################
# DIGITAL TWINS ENDPOINT EVENTHUB
#############################################################################
resource "azurerm_digital_twins_endpoint_eventhub" "digital_twins_endpoint_eventhub" {
  name                                 = var.digital_twins_endpoint_eventhub_name
  digital_twins_id                     = var.digital_twins_id
  eventhub_primary_connection_string   = var.eventhub_primary_connection_string
  eventhub_secondary_connection_string = var.eventhub_secondary_connection_string
  dead_letter_storage_secret           = var.dead_letter_storage_secret

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
