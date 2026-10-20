#############################################################################
# SECURITY CENTER WORKSPACE
#############################################################################
resource "azurerm_security_center_workspace" "security_center_workspace" {
  scope        = var.scope
  workspace_id = var.workspace_id

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
