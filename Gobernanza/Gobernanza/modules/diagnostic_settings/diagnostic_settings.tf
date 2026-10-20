#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
check "diagnostic_destination_required" {
  assert {
    condition = (
      var.log_analytics_workspace_id != null ||
      var.storage_account_id != null ||
      var.eventhub_authorization_rule_id != null
    )
    error_message = "At least one destination is required for diagnostic settings."
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings" {
  name                           = var.diagnostic_settings_name
  target_resource_id             = var.target_resource_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type
  storage_account_id             = var.storage_account_id
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  eventhub_name                  = var.eventhub_name

  dynamic "enabled_log" {
    for_each = coalesce(var.log_categories, [])

    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_metric" {
    for_each = coalesce(var.metric_categories, [])

    content {
      category = enabled_metric.value
    }
  }
}
