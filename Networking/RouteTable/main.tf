################################################################################
# Route Table
################################################################################

# DEPENDENCY: Resource Group must exist before creating this resource
resource "azurerm_route_table" "this" {
  count = var.create ? 1 : 0

  name                = local.rt_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location

  bgp_route_propagation_enabled = var.bgp_route_propagation_enabled

  tags = local.tags
}

################################################################################
# Routes
################################################################################

resource "azurerm_route" "this" {
  for_each = var.create ? var.routes : {}

  name                = each.key
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.this[0].name

  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_in_ip_address # DEPENDENCY: NVA/Firewall IP
}
