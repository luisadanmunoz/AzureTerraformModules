#############################################################################
# VIRTUAL DESKTOP HOST POOL REGISTRATION INFO
#############################################################################
resource "azurerm_virtual_desktop_host_pool_registration_info" "virtual_desktop_host_pool_registration_info" {
  hostpool_id     = var.hostpool_id
  expiration_date = var.expiration_date

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
