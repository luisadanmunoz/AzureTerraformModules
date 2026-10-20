#############################################################################
# SUBNET
#############################################################################
resource "azurerm_subnet" "subnet" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  virtual_network_name            = var.virtual_network_name
  address_prefixes                = var.address_prefixes
  service_endpoints               = var.use_service_endpoints ? var.service_endpoints : null // https://learn.microsoft.com/es-es/azure/virtual-network/virtual-network-service-endpoints-overview
  default_outbound_access_enabled = var.default_outbound_access_enabled

  #############################################################################
  # DYNAMIC BLOCKS SUBNET DELEGATION
  #############################################################################
  dynamic "delegation" {
    for_each = var.enable_delegation ? [1] : []

    content {
      name = var.name_delegation

      service_delegation {
        name    = var.name_service_delegation
        actions = var.use_actions ? var.actions : null

      }

    }

  }
  lifecycle {
    ignore_changes = [delegation]
  }
}
#############################################################################
# SUBNET NSG ASSOCIATION
#############################################################################
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  count                     = var.nsg_assoc && var.nsg_id != "" ? 1 : 0
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = var.nsg_id != "" ? var.nsg_id : null
}
#############################################################################
# SUBNET ROUTE TABLE ASSOCIATION
#############################################################################
resource "azurerm_subnet_route_table_association" "assoc-snet-rt" {
  count          = var.route_table_assoc && var.route_table_id != "" ? 1 : 0
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = var.route_table_id != "" ? var.route_table_id : null
}