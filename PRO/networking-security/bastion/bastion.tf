#############################################################################
# AZURE BASTION
#############################################################################
resource "azurerm_bastion_host" "bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  tunneling_enabled   = var.tunneling_enabled

  ip_configuration {
    name                 = var.nameip
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
  tags = var.tags
}
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
data "azurerm_monitor_diagnostic_categories" "diagnostic_setting" {
  resource_id = azurerm_bastion_host.bastion.id
}
resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                       = var.name_diagnostic_setting
  target_resource_id         = azurerm_bastion_host.bastion.id
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
    ignore_changes = [enabled_log, metric]
  }
}