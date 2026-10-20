#############################################################################
# AVAILABILITY SET
#############################################################################
resource "azurerm_availability_set" "availability_set" {
  name                         = var.availability_set_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  managed                      = var.managed
  platform_fault_domain_count  = var.platform_fault_domain_count
  platform_update_domain_count = var.platform_update_domain_count
  proximity_placement_group_id = var.proximity_placement_group_id
  tags                         = var.tags

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
