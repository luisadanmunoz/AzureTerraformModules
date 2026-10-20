#############################################################################
# ACTIVITY LOG ALERT
#############################################################################
resource "azurerm_monitor_activity_log_alert" "activity_log_alert" {
  name                = var.activity_log_alert_name
  resource_group_name = var.resource_group_name
  location            = var.location
  scopes              = var.scopes
  description         = var.description
  enabled             = var.enabled
  tags                = var.tags

  criteria {
    category       = var.category
    operation_name = var.operation_name
    level          = var.level
    status         = var.status
  }

  dynamic "action" {
    for_each = toset(var.action_group_ids)

    content {
      action_group_id = action.value
    }
  }
}
