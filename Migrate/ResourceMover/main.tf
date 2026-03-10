################################################################################
# Azure Resource Mover Move Collection
################################################################################

resource "azurerm_resource_mover_move_collection" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  source_region       = var.source_region
  target_region       = var.target_region

  identity {
    type = var.identity_type
  }

  tags = local.tags
}
