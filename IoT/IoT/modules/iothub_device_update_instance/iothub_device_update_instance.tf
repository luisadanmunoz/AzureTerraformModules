#############################################################################
# IOT HUB DEVICE UPDATE INSTANCE
#############################################################################
resource "azurerm_iothub_device_update_instance" "iothub_device_update_instance" {
  name                     = var.iothub_device_update_instance_name
  device_update_account_id = var.device_update_account_id
  iothub_id                = var.iothub_id
  diagnostic_enabled       = var.diagnostic_enabled
  tags                     = var.tags

  dynamic "diagnostic_storage_account" {
    for_each = var.diagnostic_storage_account != null ? [var.diagnostic_storage_account] : []

    content {
      connection_string = diagnostic_storage_account.value["connection_string"]
      id                = diagnostic_storage_account.value["id"]
    }
  }

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
