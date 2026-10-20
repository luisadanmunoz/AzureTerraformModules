################################################################################
# Azure Monitor Diagnostic Setting
################################################################################

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.create ? 1 : 0

  name                           = var.name
  target_resource_id             = var.target_resource_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  storage_account_id             = var.storage_account_id
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  eventhub_name                  = var.eventhub_name
  log_analytics_destination_type = var.log_analytics_destination_type

  dynamic "enabled_log" {
    for_each = var.enabled_logs
    content {
      category       = enabled_log.value.category
      category_group = enabled_log.value.category_group

      dynamic "retention_policy" {
        for_each = enabled_log.value.retention_policy != null ? [enabled_log.value.retention_policy] : []
        content {
          enabled = retention_policy.value.enabled
          days    = retention_policy.value.days
        }
      }
    }
  }

  dynamic "metric" {
    for_each = var.metrics
    content {
      category = metric.value.category
      enabled  = metric.value.enabled

      dynamic "retention_policy" {
        for_each = metric.value.retention_policy != null ? [metric.value.retention_policy] : []
        content {
          enabled = retention_policy.value.enabled
          days    = retention_policy.value.days
        }
      }
    }
  }
}
