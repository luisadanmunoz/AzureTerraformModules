################################################################################
# Network Watcher
################################################################################

resource "azurerm_network_watcher" "this" {
  count = var.create ? 1 : 0

  name                = local.watcher_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = local.tags
}

################################################################################
# Network Watcher Flow Logs
################################################################################

resource "azurerm_network_watcher_flow_log" "this" {
  for_each = var.create ? { for fl in var.flow_logs : fl.name => fl } : {}

  network_watcher_name      = azurerm_network_watcher.this[0].name
  resource_group_name       = var.resource_group_name
  name                      = each.value.name
  network_security_group_id = each.value.network_security_group_id
  storage_account_id        = each.value.storage_account_id
  enabled                   = each.value.enabled
  version                   = each.value.version

  retention_policy {
    enabled = each.value.retention_policy_enabled
    days    = each.value.retention_policy_days
  }

  dynamic "traffic_analytics" {
    for_each = each.value.traffic_analytics_enabled ? [1] : []
    content {
      enabled               = true
      workspace_id          = each.value.traffic_analytics_workspace_id
      workspace_region      = each.value.traffic_analytics_workspace_region
      workspace_resource_id = each.value.traffic_analytics_workspace_resource_id
      interval_in_minutes   = each.value.traffic_analytics_interval_in_minutes
    }
  }

  tags = local.tags
}
