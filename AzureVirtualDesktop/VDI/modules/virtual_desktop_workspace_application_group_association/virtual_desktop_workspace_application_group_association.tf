#############################################################################
# VIRTUAL DESKTOP WORKSPACE APPLICATION GROUP ASSOCIATION
#############################################################################
resource "azurerm_virtual_desktop_workspace_application_group_association" "virtual_desktop_workspace_application_group_association" {
  workspace_id         = var.workspace_id
  application_group_id = var.application_group_id

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
