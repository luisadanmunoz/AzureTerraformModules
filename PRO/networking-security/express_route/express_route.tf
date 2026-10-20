#############################################################################
# EXPRESS ROUTE CIRCUIT
#############################################################################
resource "azurerm_express_route_circuit" "express_route" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  service_provider_name = var.service_provider_name
  peering_location      = var.peering_location
  bandwidth_in_mbps     = var.bandwidth_in_mbps

  sku {
    tier   = var.tier
    family = var.family
  }
  tags = var.tags
}
#############################################################################
# EXPRESS ROUTE CIRCUIT PEERING
#############################################################################
resource "azurerm_express_route_circuit_peering" "peering" {
  peering_type                  = var.peering_type
  express_route_circuit_name    = var.express_route_circuit_name
  resource_group_name           = var.resource_group_name
  shared_key                    = var.shared_key
  peer_asn                      = var.peer_asn
  primary_peer_address_prefix   = var.primary_peer_address_prefix
  secondary_peer_address_prefix = var.secondary_peer_address_prefix
  vlan_id                       = var.vlan_id
}
#############################################################################
# VIRTUAL NETWORK GATEWAY CONNECTION - TYPE EXPRESS ROUTE
#############################################################################
resource "azurerm_virtual_network_gateway_connection" "connection" {
  name                       = var.name_connection
  location                   = var.location
  resource_group_name        = var.resource_group_name
  virtual_network_gateway_id = var.virtual_network_gateway_id
  type                       = var.type
  express_route_circuit_id   = azurerm_express_route_circuit.express_route.id
}
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
data "azurerm_monitor_diagnostic_categories" "diagnostic_setting" {
  resource_id = azurerm_express_route_circuit.express_route.id
}
resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                       = var.name_diagnostic_setting
  target_resource_id         = azurerm_express_route_circuit.express_route.id
  log_analytics_workspace_id = var.workspace_resource_id

  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_setting.log_category_types
    content {
      category = entry.value
      #enabled  = true
    }
  }
  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_setting.metrics
    content {
      category = entry.value
      enabled  = true
    }
  }
  lifecycle {
    ignore_changes = [enabled_log, metric]
  }
}