#############################################################################
# LOG ANALYTICS WORKSPACES
#############################################################################
module "log_analytics_workspace" {
  source = "./modules/log_analytics_workspace"

  for_each = var.log_analytics_workspaces

  log_analytics_workspace_name = each.value["log_analytics_workspace_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                                = each.value["location"]
  sku                                     = try(each.value["sku"], null)
  retention_in_days                       = try(each.value["retention_in_days"], null)
  daily_quota_gb                          = try(each.value["daily_quota_gb"], null)
  reservation_capacity_in_gb_per_day      = try(each.value["reservation_capacity_in_gb_per_day"], null)
  internet_ingestion_enabled              = try(each.value["internet_ingestion_enabled"], null)
  internet_query_enabled                  = try(each.value["internet_query_enabled"], null)
  local_authentication_enabled            = try(each.value["local_authentication_enabled"], null)
  allow_resource_only_permissions         = try(each.value["allow_resource_only_permissions"], null)
  cmk_for_query_forced                    = try(each.value["cmk_for_query_forced"], null)
  data_collection_rule_id                 = try(each.value["data_collection_rule_id"], null)
  immediate_data_purge_on_30_days_enabled = try(each.value["immediate_data_purge_on_30_days_enabled"], null)
  identity                                = try(each.value["identity"], null)
  timeouts                                = try(each.value["timeouts"], null)
  tags                                    = try(each.value["tags"], var.tags)
}
