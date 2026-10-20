#############################################################################
# PROXIMITY PLACEMENT GROUP
#############################################################################
resource "azurerm_proximity_placement_group" "proximity_placement_group" {
  name                = var.proximity_placement_group_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allowed_vm_sizes    = var.allowed_vm_sizes
  zone                = var.zone
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
