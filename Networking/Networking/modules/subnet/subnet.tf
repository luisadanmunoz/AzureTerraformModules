#############################################################################
# SUBNET
#############################################################################
resource "azurerm_subnet" "subnet" {
  name                                          = var.subnet_name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.virtual_network_name
  address_prefixes                              = var.address_prefixes
  service_endpoints                             = var.service_endpoints
  service_endpoint_policy_ids                   = var.service_endpoint_policy_ids
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies

  dynamic "delegation" {
    for_each = coalesce(var.delegations, [])

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = try(delegation.value.service_delegation.actions, null)
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  count = var.associate_nsg ? 1 : 0

  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = var.nsg_id
}

resource "azurerm_subnet_route_table_association" "subnet_route_table" {
  count = var.associate_route_table ? 1 : 0

  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = var.route_table_id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway" {
  count = var.associate_nat_gateway ? 1 : 0

  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = var.nat_gateway_id
}
