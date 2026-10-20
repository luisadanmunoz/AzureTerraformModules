#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
module "diagnostic_settings" {
  source = "./modules/diagnostic_settings"

  for_each = var.diagnostic_settings

  diagnostic_settings_name       = each.value["diagnostic_settings_name"]
  target_resource_id             = each.value["target_resource_id"]
  log_analytics_workspace_id     = try(each.value["log_analytics_workspace_id"], null)
  log_analytics_destination_type = try(each.value["log_analytics_destination_type"], null)
  storage_account_id             = try(each.value["storage_account_id"], null)
  eventhub_authorization_rule_id = try(each.value["eventhub_authorization_rule_id"], null)
  eventhub_name                  = try(each.value["eventhub_name"], null)
  log_categories                 = coalesce(try(each.value["log_categories"], null), [])
  metric_categories              = coalesce(try(each.value["metric_categories"], null), ["AllMetrics"])
}
