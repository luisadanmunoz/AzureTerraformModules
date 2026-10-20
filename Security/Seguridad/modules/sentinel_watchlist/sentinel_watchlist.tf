#############################################################################
# SENTINEL WATCHLIST
#############################################################################
resource "azurerm_sentinel_watchlist" "sentinel_watchlist" {
  name                       = var.sentinel_watchlist_name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  display_name               = var.display_name
  item_search_key            = var.item_search_key
  default_duration           = var.default_duration
  description                = var.description
  labels                     = var.labels

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
