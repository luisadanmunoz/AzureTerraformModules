# #############################################################################
# MONITOR ACTIVITY LOG ALERT
# #############################################################################
resource "azurerm_monitor_activity_log_alert" "monitor_activity_log_alert" {

  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = var.description
  location            = var.location

  criteria {

    category = var.category

    //operation_name = var.operation_name != "" ? var.operation_name : null
    //statuses = var.statuses != "" ? var.statuses : null 
  }

  action {
    action_group_id = var.action_group_id

  }
}