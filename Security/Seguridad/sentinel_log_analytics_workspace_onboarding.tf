#############################################################################
# SENTINEL LOG ANALYTICS WORKSPACE ONBOARDINGS
#############################################################################
module "sentinel_log_analytics_workspace_onboarding" {
  source = "./modules/sentinel_log_analytics_workspace_onboarding"

  for_each = var.sentinel_log_analytics_workspace_onboardings

  workspace_id = try(
    element([for _, workspace in module.log_analytics_workspace : workspace.id if workspace.name == each.value["log_analytics_workspace_name"]], 0),
    each.value["workspace_id"]
  )
  customer_managed_key_enabled = try(each.value["customer_managed_key_enabled"], null)
  timeouts                     = try(each.value["timeouts"], null)
}
