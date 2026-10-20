# #############################################################################
# PUBLIC IP MODULE
# #############################################################################
resource "azurerm_public_ip" "public_ip" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = var.allocation_method
  sku               = var.sku
  zones             = var.zones

  tags = var.tags
}
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
data "azurerm_monitor_diagnostic_categories" "diagnostic_setting" {
  resource_id = azurerm_public_ip.public_ip.id
}
resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                       = var.name_diagnostic_setting
  target_resource_id         = azurerm_public_ip.public_ip.id
  log_analytics_workspace_id = var.workspace_resource_id

  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_setting.log_category_types
    content {
      category = entry.value
      #enabled  = true
    }
  }
  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_setting.metrics
    content {
      category = entry.value
      enabled  = true
    }
  }

  lifecycle {
    ignore_changes = [metric, enabled_log]
  }
}