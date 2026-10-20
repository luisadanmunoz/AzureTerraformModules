#############################################################################
# SECURITY CENTER AUTO PROVISIONING
#############################################################################
resource "azurerm_security_center_auto_provisioning" "security_center_auto_provisioning" {
  auto_provision = var.auto_provision

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
