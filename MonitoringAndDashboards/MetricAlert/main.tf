################################################################################
# Azure Monitor Metric Alert
################################################################################

resource "azurerm_monitor_metric_alert" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = var.description
  enabled             = var.enabled
  auto_mitigate       = var.auto_mitigate
  frequency           = var.frequency
  severity            = var.severity
  window_size         = var.window_size

  dynamic "criteria" {
    for_each = var.criteria
    content {
      metric_namespace = criteria.value.metric_namespace
      metric_name      = criteria.value.metric_name
      aggregation      = criteria.value.aggregation
      operator         = criteria.value.operator
      threshold        = criteria.value.threshold
    }
  }

  dynamic "action" {
    for_each = var.action_group_ids
    content {
      action_group_id = action.value
    }
  }

  tags = local.tags
}
