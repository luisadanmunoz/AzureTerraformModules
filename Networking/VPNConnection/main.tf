################################################################################
# Virtual Network Gateway Connection
################################################################################

resource "azurerm_virtual_network_gateway_connection" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location

  type                            = var.type
  virtual_network_gateway_id      = var.virtual_network_gateway_id
  peer_virtual_network_gateway_id = var.type == "Vnet2Vnet" ? var.peer_virtual_network_gateway_id : null
  local_network_gateway_id        = var.type == "IPsec" ? var.local_network_gateway_id : null
  express_route_circuit_id        = var.type == "ExpressRoute" ? var.express_route_circuit_id : null

  shared_key          = var.type != "ExpressRoute" ? var.shared_key : null
  connection_protocol = var.type != "ExpressRoute" ? var.connection_protocol : null
  enable_bgp          = var.enable_bgp

  dpd_timeout_seconds                = var.dpd_timeout_seconds
  use_policy_based_traffic_selectors = var.use_policy_based_traffic_selectors

  # IPsec Policy
  dynamic "ipsec_policy" {
    for_each = var.ipsec_policy != null ? [var.ipsec_policy] : []
    content {
      dh_group         = ipsec_policy.value.dh_group
      ike_encryption   = ipsec_policy.value.ike_encryption
      ike_integrity    = ipsec_policy.value.ike_integrity
      ipsec_encryption = ipsec_policy.value.ipsec_encryption
      ipsec_integrity  = ipsec_policy.value.ipsec_integrity
      pfs_group        = ipsec_policy.value.pfs_group
      sa_lifetime      = ipsec_policy.value.sa_lifetime
      sa_datasize      = ipsec_policy.value.sa_datasize
    }
  }

  # Traffic Selector Policy
  dynamic "traffic_selector_policy" {
    for_each = var.traffic_selector_policy
    content {
      local_address_cidrs  = traffic_selector_policy.value.local_address_cidrs
      remote_address_cidrs = traffic_selector_policy.value.remote_address_cidrs
    }
  }

  tags = local.tags
}
