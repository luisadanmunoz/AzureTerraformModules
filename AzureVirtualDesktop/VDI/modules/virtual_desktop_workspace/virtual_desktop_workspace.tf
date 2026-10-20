#############################################################################
# VIRTUAL DESKTOP WORKSPACE
#############################################################################
resource "azurerm_virtual_desktop_workspace" "virtual_desktop_workspace" {
  name                          = var.virtual_desktop_workspace_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  friendly_name                 = var.friendly_name
  description                   = var.description
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

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
