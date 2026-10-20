#############################################################################
# IOT HUB FILE UPLOAD
#############################################################################
resource "azurerm_iothub_file_upload" "iothub_file_upload" {
  iothub_id             = var.iothub_id
  connection_string     = var.connection_string
  container_name        = var.container_name
  authentication_type   = var.authentication_type
  identity_id           = var.identity_id
  default_ttl           = var.default_ttl
  lock_duration         = var.lock_duration
  max_delivery_count    = var.max_delivery_count
  notifications_enabled = var.notifications_enabled
  sas_ttl               = var.sas_ttl

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
