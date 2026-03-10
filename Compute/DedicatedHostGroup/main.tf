################################################################################
# Dedicated Host Group
################################################################################

# DEPENDENCY: Resource Group must exist

resource "azurerm_dedicated_host_group" "this" {
  count = var.create ? 1 : 0

  name                        = local.resource_name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  platform_fault_domain_count = var.platform_fault_domain_count
  zone                        = var.zone
  automatic_placement_enabled = var.automatic_placement_enabled

  tags = local.tags
}
