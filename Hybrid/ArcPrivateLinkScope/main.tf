################################################################################
# Azure Arc Private Link Scope
################################################################################

resource "azurerm_arc_private_link_scope" "this" {
  count = var.create ? 1 : 0

  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  public_network_access_enabled = var.public_network_access_enabled

  tags = local.tags
}
