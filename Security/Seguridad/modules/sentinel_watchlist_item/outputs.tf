#############################################################################
# OUTPUT SENTINEL WATCHLIST ITEM
#############################################################################
output "id" {
  value = azurerm_sentinel_watchlist_item.sentinel_watchlist_item.id
}

output "name" {
  value = azurerm_sentinel_watchlist_item.sentinel_watchlist_item.name
}
