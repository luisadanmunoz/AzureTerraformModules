#############################################################################
# ACTIVITY LOG ALERTS
#############################################################################
module "activity_log_alert" {
  source = "./modules/activity_log_alert"

  for_each = var.activity_log_alerts

  activity_log_alert_name = each.value["activity_log_alert_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location       = try(each.value["location"], "global")
  scopes         = each.value["scopes"]
  operation_name = try(each.value["operation_name"], null)
  category       = try(each.value["category"], null)
  level          = try(each.value["level"], null)
  status         = try(each.value["status"], null)
  action_group_ids = try(
    length(coalesce(try(each.value["action_group_names"], null), [])) > 0 ? [
      for name in each.value["action_group_names"] :
      element([for _, action_group in module.monitor_action_group : action_group.id if action_group.name == name], 0)
    ] : each.value["action_group_ids"],
    each.value["action_group_ids"],
    []
  )
  description = try(each.value["description"], null)
  enabled     = try(each.value["enabled"], true)
  tags        = var.tags
}
