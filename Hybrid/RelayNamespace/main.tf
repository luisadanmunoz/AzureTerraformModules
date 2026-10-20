################################################################################
# Azure Relay Namespace
################################################################################

resource "azurerm_relay_namespace" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name

  tags = local.tags
}
