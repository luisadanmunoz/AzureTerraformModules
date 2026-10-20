################################################################################
# Local Network Gateway
################################################################################

resource "azurerm_local_network_gateway" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource group must exist.
  location            = var.location

  gateway_address = var.gateway_address
  gateway_fqdn    = var.gateway_fqdn
  address_space   = var.address_space

  dynamic "bgp_settings" {
    for_each = var.bgp_settings != null ? [var.bgp_settings] : []
    content {
      asn                 = bgp_settings.value.asn
      bgp_peering_address = bgp_settings.value.bgp_peering_address
      peer_weight         = bgp_settings.value.peer_weight
    }
  }

  tags = local.tags
}
