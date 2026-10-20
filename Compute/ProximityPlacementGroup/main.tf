################################################################################
# Proximity Placement Group
################################################################################

# DEPENDENCY: Resource Group must exist

resource "azurerm_proximity_placement_group" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allowed_vm_sizes    = length(var.allowed_vm_sizes) > 0 ? var.allowed_vm_sizes : null
  zone                = var.zone

  tags = local.tags
}
