#############################################################################
# NETWORK WATCHER
#############################################################################
resource "azurerm_network_watcher" "network_watcher" {
  name                = var.network_watcher_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}
