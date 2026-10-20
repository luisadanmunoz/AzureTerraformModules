#############################################################################
# SECURITY CENTER SETTING
#############################################################################
resource "azurerm_security_center_setting" "security_center_setting" {
  setting_name = var.setting_name
  enabled      = var.enabled

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
