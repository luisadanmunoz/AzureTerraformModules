#############################################################################
# NETWORK SECURITY RULE
#############################################################################
module "monitor_scheduled_query_rules_alert" {
  source = "./modules/monitor_scheduled_query_rules_alert"

  for_each = var.monitor_scheduled_query_rules_alert

  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]
  severity            = each.value["severity"]
  enabled             = each.value["enabled"]
  description         = each.value["description"]
  log_analytics       = element([for k, v in module.log_analytics : v.id if v.name == each.value["log_analytics"]], 0)
  query               = each.value["query"]
  time_window         = each.value["time_window"]
  frequency           = each.value["frequency"]
  threshold           = each.value["threshold"]
  operator            = each.value["operator"]
  action_group_id     = each.value["action_group_id"]


}