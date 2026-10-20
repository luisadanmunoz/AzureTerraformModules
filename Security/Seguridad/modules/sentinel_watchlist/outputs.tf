#############################################################################
# OUTPUT SENTINEL WATCHLIST
#############################################################################
output "id" {
  value = azurerm_sentinel_watchlist.sentinel_watchlist.id
}

output "name" {
  value = azurerm_sentinel_watchlist.sentinel_watchlist.name
}
