################################################################################
# Availability Set
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Proximity Placement Group must exist (if specified)

resource "azurerm_availability_set" "this" {
  count = var.create ? 1 : 0

  name                         = local.resource_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  platform_fault_domain_count  = var.platform_fault_domain_count
  platform_update_domain_count = var.platform_update_domain_count
  proximity_placement_group_id = var.proximity_placement_group_id
  managed                      = var.managed

  tags = local.tags
}
