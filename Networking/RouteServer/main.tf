################################################################################
# Public IP (Optional - for Route Server)
################################################################################

resource "azurerm_public_ip" "this" {
  count = var.create && var.public_ip_address_id == null ? 1 : 0

  name                = local.pip_name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"

  tags = local.tags
}

################################################################################
# Route Server
################################################################################

# DEPENDENCY: Resource Group and RouteServerSubnet must exist before creating this resource
resource "azurerm_route_server" "this" {
  count = var.create ? 1 : 0

  name                = local.route_server_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location

  sku                              = var.sku
  subnet_id                        = var.subnet_id # DEPENDENCY: RouteServerSubnet
  public_ip_address_id             = local.public_ip_id
  branch_to_branch_traffic_enabled = var.branch_to_branch_traffic_enabled

  tags = local.tags
}

################################################################################
# Route Server BGP Connections
################################################################################

# DEPENDENCY: Route Server must be created before BGP connections
resource "azurerm_route_server_bgp_connection" "this" {
  for_each = var.create ? local.bgp_connections_map : {}

  name            = each.value.name
  route_server_id = azurerm_route_server.this[0].id
  peer_asn        = each.value.peer_asn
  peer_ip         = each.value.peer_ip
}
