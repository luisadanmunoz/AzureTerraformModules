################################################################################
# Azure Front Door Profile
################################################################################

resource "azurerm_cdn_frontdoor_profile" "this" {
  count = var.create ? 1 : 0

  name                     = var.name
  resource_group_name      = var.resource_group_name
  sku_name                 = var.sku_name
  response_timeout_seconds = var.response_timeout_seconds

  tags = local.tags
}
