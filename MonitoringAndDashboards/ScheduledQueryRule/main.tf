################################################################################
# Azure Monitor Scheduled Query Rule Alert
################################################################################

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "this" {
  count = var.create ? 1 : 0

  name                    = var.name
  resource_group_name     = var.resource_group_name
  location                = var.location
  scopes                  = var.scopes
  description             = var.description
  enabled                 = var.enabled
  severity                = var.severity
  evaluation_frequency    = var.evaluation_frequency
  window_duration         = var.window_duration
  auto_mitigation_enabled = var.auto_mitigation_enabled

  criteria {
    query                   = var.criteria.query
    time_aggregation_method = var.criteria.time_aggregation_method
    threshold               = var.criteria.threshold
    operator                = var.criteria.operator
    metric_measure_column   = var.criteria.metric_measure_column
    resource_id_column      = var.criteria.resource_id_column

    dynamic "dimension" {
      for_each = var.criteria.dimension
      content {
        name     = dimension.value.name
        operator = dimension.value.operator
        values   = dimension.value.values
      }
    }

    dynamic "failing_periods" {
      for_each = var.criteria.failing_periods != null ? [var.criteria.failing_periods] : []
      content {
        minimum_failing_periods_to_trigger_alert = failing_periods.value.minimum_failing_periods_to_trigger_alert
        number_of_evaluation_periods             = failing_periods.value.number_of_evaluation_periods
      }
    }
  }

  dynamic "action" {
    for_each = length(var.action_group_ids) > 0 ? [1] : []
    content {
      action_groups = var.action_group_ids
    }
  }

  tags = local.tags
}
