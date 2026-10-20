################################################################################
# Azure CDN Profile
################################################################################

resource "azurerm_cdn_profile" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  tags = local.tags
}
