#############################################################################
# VIRTUAL DESKTOP APPLICATION GROUP
#############################################################################
resource "azurerm_virtual_desktop_application_group" "virtual_desktop_application_group" {
  name                         = var.virtual_desktop_application_group_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  type                         = var.type
  host_pool_id                 = var.host_pool_id
  friendly_name                = var.friendly_name
  default_desktop_display_name = var.default_desktop_display_name
  description                  = var.description
  tags                         = var.tags

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
