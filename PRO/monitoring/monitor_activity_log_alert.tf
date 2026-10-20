# #############################################################################
# MONITOR ACTIVITY LOG ALERT
# #############################################################################
module "monitor_activity_log_alert" {
  source = "./modules/monitor_activity_log_alert"

  for_each = var.monitor_activity_log_alert

  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]
  scopes              = each.value["scopes"]
  description         = each.value["description"]
  category            = each.value["category"]
  //operation_name      = each.value["operation_name"]
  //statuses            = each.value["statuses"]
  action_group_id = element([for k, v in module.action_group : v.id if v.name == each.value["action_group"]], 0)
}