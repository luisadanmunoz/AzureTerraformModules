#############################################################################
# SENTINEL WATCHLIST ITEMS
#############################################################################
module "sentinel_watchlist_item" {
  source = "./modules/sentinel_watchlist_item"

  for_each = var.sentinel_watchlist_items

  watchlist_id = try(
    element([for _, sentinel_watchlist in module.sentinel_watchlist : sentinel_watchlist.id if sentinel_watchlist.name == each.value["sentinel_watchlist_name"]], 0),
    each.value["watchlist_id"]
  )
  name       = try(each.value["name"], null)
  properties = each.value["properties"]
  timeouts   = try(each.value["timeouts"], null)
}
