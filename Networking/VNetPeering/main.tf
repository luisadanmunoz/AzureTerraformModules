################################################################################
# VNet Peering (Local to Remote)
################################################################################

# DEPENDENCY: Both Virtual Networks must exist before creating peering
resource "azurerm_virtual_network_peering" "this" {
  count = var.create ? 1 : 0

  name                      = local.peering_name
  resource_group_name       = var.resource_group_name  # DEPENDENCY: Resource Group
  virtual_network_name      = var.virtual_network_name # DEPENDENCY: Local Virtual Network
  remote_virtual_network_id = var.remote_virtual_network_id # DEPENDENCY: Remote Virtual Network

  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit # DEPENDENCY: Requires VNet Gateway if true
  use_remote_gateways          = var.use_remote_gateways   # DEPENDENCY: Remote VNet must have gateway

  local_subnet_names  = var.local_subnet_names
  remote_subnet_names = var.remote_subnet_names
}

################################################################################
# VNet Peering (Remote to Local) - Bidirectional
################################################################################

# DEPENDENCY: Requires permissions on remote subscription
resource "azurerm_virtual_network_peering" "reverse" {
  count = var.create && var.create_reverse_peering ? 1 : 0

  name                      = local.reverse_peering_name
  resource_group_name       = var.reverse_peering_resource_group_name # DEPENDENCY: Remote Resource Group
  virtual_network_name      = local.remote_vnet_name                  # DEPENDENCY: Remote Virtual Network
  remote_virtual_network_id = local.local_vnet_id                     # DEPENDENCY: Local Virtual Network

  allow_virtual_network_access = var.reverse_allow_virtual_network_access
  allow_forwarded_traffic      = var.reverse_allow_forwarded_traffic
  allow_gateway_transit        = var.reverse_allow_gateway_transit
  use_remote_gateways          = var.reverse_use_remote_gateways

  depends_on = [azurerm_virtual_network_peering.this]
}
