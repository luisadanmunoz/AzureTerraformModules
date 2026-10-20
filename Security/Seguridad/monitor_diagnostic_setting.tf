#############################################################################
# MONITOR DIAGNOSTIC SETTINGS
#############################################################################
module "monitor_diagnostic_setting" {
  source = "./modules/monitor_diagnostic_setting"

  for_each = var.monitor_diagnostic_settings

  monitor_diagnostic_setting_name = each.value["monitor_diagnostic_setting_name"]
  target_resource_id              = each.value["target_resource_id"]
  log_analytics_workspace_id = try(
    element([for _, log_analytics_workspace in module.log_analytics_workspace : log_analytics_workspace.id if log_analytics_workspace.name == each.value["log_analytics_workspace_name"]], 0),
    each.value["log_analytics_workspace_id"]
  )
  log_analytics_destination_type = try(each.value["log_analytics_destination_type"], null)
  storage_account_id             = try(each.value["storage_account_id"], null)
  eventhub_authorization_rule_id = try(each.value["eventhub_authorization_rule_id"], null)
  eventhub_name                  = try(each.value["eventhub_name"], null)
  partner_solution_id            = try(each.value["partner_solution_id"], null)
  enabled_logs                   = try(each.value["enabled_logs"], [])
  enabled_metrics                = try(each.value["enabled_metrics"], [])
  metrics                        = try(each.value["metrics"], [])
  timeouts                       = try(each.value["timeouts"], null)
}
