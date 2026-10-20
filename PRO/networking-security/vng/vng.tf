#############################################################################
# VIRTUAL NETWORK GATEWAY
#############################################################################
resource "azurerm_virtual_network_gateway" "vng" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = var.type
  vpn_type = var.vpn_type

  active_active = var.active_active
  enable_bgp    = var.enable_bgp
  sku           = var.sku

  tags = var.tags

  ip_configuration {
    public_ip_address_id = var.public_ip_address_id
    subnet_id            = var.subnet_id
  }
}
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
data "azurerm_monitor_diagnostic_categories" "diagnostic_setting" {
  resource_id = azurerm_virtual_network_gateway.vng.id
}
resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                       = var.name_diagnostic_setting
  target_resource_id         = azurerm_virtual_network_gateway.vng.id
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