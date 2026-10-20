#############################################################################
# SENTINEL WATCHLISTS
#############################################################################
module "sentinel_watchlist" {
  source = "./modules/sentinel_watchlist"

  for_each = var.sentinel_watchlists

  sentinel_watchlist_name = each.value["sentinel_watchlist_name"]
  log_analytics_workspace_id = try(
    element([for _, log_analytics_workspace in module.log_analytics_workspace : log_analytics_workspace.id if log_analytics_workspace.name == each.value["log_analytics_workspace_name"]], 0),
    each.value["log_analytics_workspace_id"]
  )
  display_name     = each.value["display_name"]
  item_search_key  = each.value["item_search_key"]
  default_duration = try(each.value["default_duration"], null)
  description      = try(each.value["description"], null)
  labels           = try(each.value["labels"], null)
  timeouts         = try(each.value["timeouts"], null)
}
