################################################################################
# Subnet
################################################################################

# DEPENDENCY: Virtual Network must exist before creating this resource
resource "azurerm_subnet" "this" {
  count = var.create ? 1 : 0

  name                 = local.subnet_name
  resource_group_name  = var.resource_group_name  # DEPENDENCY: Resource Group
  virtual_network_name = var.virtual_network_name # DEPENDENCY: Virtual Network

  address_prefixes = var.address_prefixes

  # Private endpoint and private link settings
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  default_outbound_access_enabled               = var.default_outbound_access_enabled

  # Service endpoints
  service_endpoints           = length(var.service_endpoints) > 0 ? var.service_endpoints : null
  service_endpoint_policy_ids = length(var.service_endpoint_policy_ids) > 0 ? var.service_endpoint_policy_ids : null

  # Service delegation
  dynamic "delegation" {
    for_each = var.delegation != null ? [var.delegation] : []

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}

################################################################################
# Network Security Group Association
################################################################################

# DEPENDENCY: Network Security Group must exist before association
resource "azurerm_subnet_network_security_group_association" "this" {
  count = local.create_nsg_association ? 1 : 0

  subnet_id                 = azurerm_subnet.this[0].id
  network_security_group_id = var.network_security_group_id # DEPENDENCY: NSG
}

################################################################################
# Route Table Association
################################################################################

# DEPENDENCY: Route Table must exist before association
resource "azurerm_subnet_route_table_association" "this" {
  count = local.create_route_table_association ? 1 : 0

  subnet_id      = azurerm_subnet.this[0].id
  route_table_id = var.route_table_id # DEPENDENCY: Route Table
}

################################################################################
# NAT Gateway Association
################################################################################

# DEPENDENCY: NAT Gateway must exist before association
resource "azurerm_subnet_nat_gateway_association" "this" {
  count = local.create_nat_gateway_association ? 1 : 0

  subnet_id      = azurerm_subnet.this[0].id
  nat_gateway_id = var.nat_gateway_id # DEPENDENCY: NAT Gateway
}
