#############################################################################
# MONITOR DIAGNOSTIC SETTING
#############################################################################
resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting" {
  name                           = var.monitor_diagnostic_setting_name
  target_resource_id             = var.target_resource_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type
  storage_account_id             = var.storage_account_id
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  eventhub_name                  = var.eventhub_name
  partner_solution_id            = var.partner_solution_id

  dynamic "enabled_log" {
    for_each = var.enabled_logs != null ? var.enabled_logs : []

    content {
      category       = try(enabled_log.value["category"], null)
      category_group = try(enabled_log.value["category_group"], null)

      dynamic "retention_policy" {
        for_each = try(enabled_log.value["retention_policy"], null) != null ? [enabled_log.value["retention_policy"]] : []

        content {
          enabled = retention_policy.value["enabled"]
          days    = try(retention_policy.value["days"], null)
        }
      }
    }
  }

  dynamic "enabled_metric" {
    for_each = var.enabled_metrics != null ? var.enabled_metrics : []

    content {
      category = enabled_metric.value["category"]
    }
  }

  dynamic "metric" {
    for_each = var.metrics != null ? var.metrics : []

    content {
      category = metric.value["category"]
      enabled  = try(metric.value["enabled"], null)

      dynamic "retention_policy" {
        for_each = try(metric.value["retention_policy"], null) != null ? [metric.value["retention_policy"]] : []

        content {
          enabled = retention_policy.value["enabled"]
          days    = try(retention_policy.value["days"], null)
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition     = var.log_analytics_workspace_id != null || var.storage_account_id != null || var.eventhub_authorization_rule_id != null || var.partner_solution_id != null
      error_message = "At least one destination must be configured in monitor_diagnostic_setting."
    }

    precondition {
      condition     = length(var.enabled_logs) > 0 || length(var.enabled_metrics) > 0 || length(var.metrics) > 0
      error_message = "At least one enabled_log, enabled_metric or metric block must be configured in monitor_diagnostic_setting."
    }
  }
}
