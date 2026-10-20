#############################################################################
# PUBLIC IP
#############################################################################
resource "azurerm_public_ip" "public_ip" {
  name                    = var.public_ip_name
  resource_group_name     = var.resource_group_name
  location                = var.location
  allocation_method       = var.allocation_method
  sku                     = var.sku
  sku_tier                = var.sku_tier
  domain_name_label       = var.domain_name_label
  reverse_fqdn            = var.reverse_fqdn
  ip_version              = var.ip_version
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  zones                   = var.zones
  tags                    = var.tags
}
