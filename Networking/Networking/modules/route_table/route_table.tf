#############################################################################
# ROUTE TABLE
#############################################################################
resource "azurerm_route_table" "route_table" {
  name                          = var.route_table_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  bgp_route_propagation_enabled = var.bgp_route_propagation_enabled
  tags                          = var.tags

  dynamic "route" {
    for_each = coalesce(var.routes, [])

    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = try(route.value.next_hop_in_ip_address, null)
    }
  }
}
