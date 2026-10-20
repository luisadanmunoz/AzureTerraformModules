#############################################################################
# SENTINEL WATCHLIST ITEM
#############################################################################
resource "azurerm_sentinel_watchlist_item" "sentinel_watchlist_item" {
  watchlist_id = var.watchlist_id
  name         = var.name
  properties   = var.properties

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
