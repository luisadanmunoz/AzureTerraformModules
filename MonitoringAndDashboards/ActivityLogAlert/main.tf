################################################################################
# Azure Monitor Activity Log Alert
################################################################################

resource "azurerm_monitor_activity_log_alert" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = var.description
  enabled             = var.enabled

  criteria {
    category                = var.criteria.category
    operation_name          = var.criteria.operation_name
    resource_provider       = var.criteria.resource_provider
    resource_type           = var.criteria.resource_type
    resource_group          = var.criteria.resource_group
    caller                  = var.criteria.caller
    level                   = var.criteria.level
    status                  = var.criteria.status
    sub_status              = var.criteria.sub_status
    recommendation_type     = var.criteria.recommendation_type
    recommendation_category = var.criteria.recommendation_category
    recommendation_impact   = var.criteria.recommendation_impact
  }

  dynamic "action" {
    for_each = var.action_group_ids
    content {
      action_group_id = action.value
    }
  }

  tags = local.tags
}
