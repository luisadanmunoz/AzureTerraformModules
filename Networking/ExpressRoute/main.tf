################################################################################
# ExpressRoute Circuit
################################################################################

resource "azurerm_express_route_circuit" "this" {
  count = var.create ? 1 : 0

  name                = local.circuit_name
  resource_group_name = var.resource_group_name
  location            = var.location

  service_provider_name = var.express_route_port_id == null ? var.service_provider_name : null
  peering_location      = var.express_route_port_id == null ? var.peering_location : null
  bandwidth_in_mbps     = var.express_route_port_id == null ? var.bandwidth_in_mbps : null

  express_route_port_id = var.express_route_port_id
  bandwidth_in_gbps     = var.express_route_port_id != null ? var.bandwidth_in_gbps : null
  authorization_key     = var.authorization_key

  allow_classic_operations = var.allow_classic_operations

  sku {
    tier   = var.sku_tier
    family = var.sku_family
  }

  tags = local.tags
}

################################################################################
# ExpressRoute Circuit Peerings
################################################################################

resource "azurerm_express_route_circuit_peering" "this" {
  count = var.create ? length(var.peerings) : 0

  express_route_circuit_name = azurerm_express_route_circuit.this[0].name
  resource_group_name        = var.resource_group_name

  peering_type                  = var.peerings[count.index].peering_type
  vlan_id                       = var.peerings[count.index].vlan_id
  primary_peer_address_prefix   = var.peerings[count.index].primary_peer_address_prefix
  secondary_peer_address_prefix = var.peerings[count.index].secondary_peer_address_prefix
  peer_asn                      = var.peerings[count.index].peer_asn
  shared_key                    = var.peerings[count.index].shared_key

  dynamic "microsoft_peering_config" {
    for_each = var.peerings[count.index].microsoft_peering_config != null ? [var.peerings[count.index].microsoft_peering_config] : []
    content {
      advertised_public_prefixes = microsoft_peering_config.value.advertised_public_prefixes
      customer_asn               = microsoft_peering_config.value.customer_asn
      routing_registry_name      = microsoft_peering_config.value.routing_registry_name
      advertised_communities     = microsoft_peering_config.value.advertised_communities
    }
  }
}

################################################################################
# Diagnostic Settings
################################################################################

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                           = var.diagnostic_settings.name
  target_resource_id             = azurerm_express_route_circuit.this[0].id
  log_analytics_workspace_id     = var.diagnostic_settings.log_analytics_workspace_id
  storage_account_id             = var.diagnostic_settings.storage_account_id
  eventhub_authorization_rule_id = var.diagnostic_settings.eventhub_authorization_rule_id
  eventhub_name                  = var.diagnostic_settings.eventhub_name

  dynamic "enabled_log" {
    for_each = var.diagnostic_settings.log_categories
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.diagnostic_settings.metric_categories
    content {
      category = metric.value
      enabled  = true
    }
  }
}
