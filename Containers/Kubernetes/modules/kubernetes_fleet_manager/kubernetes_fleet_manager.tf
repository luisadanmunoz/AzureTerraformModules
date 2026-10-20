#############################################################################
# KUBERNETES FLEET MANAGER
#############################################################################
resource "azurerm_kubernetes_fleet_manager" "kubernetes_fleet_manager" {
  name                = var.kubernetes_fleet_manager_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

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
