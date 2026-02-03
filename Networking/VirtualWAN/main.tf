################################################################################
# Virtual WAN
################################################################################

resource "azurerm_virtual_wan" "this" {
  count = var.create ? 1 : 0

  name                = local.vwan_name
  resource_group_name = var.resource_group_name
  location            = var.location

  disable_vpn_encryption            = var.disable_vpn_encryption
  allow_branch_to_branch_traffic    = var.allow_branch_to_branch_traffic
  office365_local_breakout_category = var.office365_local_breakout_category
  type                              = var.type

  tags = local.tags
}

################################################################################
# Virtual Hubs
################################################################################

resource "azurerm_virtual_hub" "this" {
  for_each = var.create ? local.virtual_hubs_map : {}

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = each.value.location
  virtual_wan_id      = azurerm_virtual_wan.this[0].id
  address_prefix      = each.value.address_prefix
  sku                 = each.value.sku

  hub_routing_preference                 = each.value.hub_routing_preference
  virtual_router_auto_scale_min_capacity = each.value.virtual_router_auto_scale_min_capacity

  tags = local.tags
}

################################################################################
# VPN Gateways (Virtual WAN)
################################################################################

resource "azurerm_vpn_gateway" "this" {
  for_each = var.create ? local.vpn_gateways_map : {}

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = azurerm_virtual_hub.this[each.value.virtual_hub_key].location
  virtual_hub_id      = azurerm_virtual_hub.this[each.value.virtual_hub_key].id

  bgp_route_translation_for_nat_enabled = each.value.bgp_route_translation_for_nat_enabled
  routing_preference                    = each.value.routing_preference
  scale_unit                            = each.value.scale_unit

  dynamic "bgp_settings" {
    for_each = each.value.bgp_settings != null ? [each.value.bgp_settings] : []
    content {
      asn         = bgp_settings.value.asn
      peer_weight = bgp_settings.value.peer_weight

      dynamic "instance_0_bgp_peering_address" {
        for_each = bgp_settings.value.instance_0_bgp_peering_address != null ? [bgp_settings.value.instance_0_bgp_peering_address] : []
        content {
          custom_ips = instance_0_bgp_peering_address.value.custom_ips
        }
      }

      dynamic "instance_1_bgp_peering_address" {
        for_each = bgp_settings.value.instance_1_bgp_peering_address != null ? [bgp_settings.value.instance_1_bgp_peering_address] : []
        content {
          custom_ips = instance_1_bgp_peering_address.value.custom_ips
        }
      }
    }
  }

  tags = local.tags
}

################################################################################
# VPN Sites
################################################################################

resource "azurerm_vpn_site" "this" {
  for_each = var.create ? local.vpn_sites_map : {}

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_wan_id      = azurerm_virtual_wan.this[0].id

  address_cidrs = each.value.address_cidrs
  device_model  = each.value.device_model
  device_vendor = each.value.device_vendor

  dynamic "link" {
    for_each = each.value.links
    content {
      name          = link.value.name
      ip_address    = link.value.ip_address
      fqdn          = link.value.fqdn
      provider_name = link.value.provider_name
      speed_in_mbps = link.value.speed_in_mbps

      dynamic "bgp" {
        for_each = link.value.bgp != null ? [link.value.bgp] : []
        content {
          asn             = bgp.value.asn
          peering_address = bgp.value.peering_address
        }
      }
    }
  }

  tags = local.tags
}

################################################################################
# ExpressRoute Gateways
################################################################################

resource "azurerm_express_route_gateway" "this" {
  for_each = var.create ? local.er_gateways_map : {}

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = azurerm_virtual_hub.this[each.value.virtual_hub_key].location
  virtual_hub_id      = azurerm_virtual_hub.this[each.value.virtual_hub_key].id
  scale_units         = each.value.scale_unit

  allow_non_virtual_wan_traffic = each.value.allow_non_virtual_wan_traffic

  tags = local.tags
}
