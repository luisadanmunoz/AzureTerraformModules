################################################################################
# Azure Arc-enabled Server
################################################################################

resource "azurerm_arc_machine" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = var.kind

  identity {
    type = var.identity_type
  }

  tags = local.tags
}
