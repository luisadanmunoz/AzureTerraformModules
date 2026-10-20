#############################################################################
# DIGITAL TWINS ENDPOINT EVENTGRID
#############################################################################
resource "azurerm_digital_twins_endpoint_eventgrid" "digital_twins_endpoint_eventgrid" {
  name                                 = var.digital_twins_endpoint_eventgrid_name
  digital_twins_id                     = var.digital_twins_id
  eventgrid_topic_endpoint             = var.eventgrid_topic_endpoint
  eventgrid_topic_primary_access_key   = var.eventgrid_topic_primary_access_key
  eventgrid_topic_secondary_access_key = var.eventgrid_topic_secondary_access_key
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
