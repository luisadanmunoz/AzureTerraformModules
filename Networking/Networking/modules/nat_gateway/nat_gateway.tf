#############################################################################
# NAT GATEWAY
#############################################################################
resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = var.nat_gateway_name
  resource_group_name     = var.resource_group_name
  location                = var.location
  sku_name                = var.sku_name
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  tags                    = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip" {
  for_each = var.public_ip_id_map

  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = each.value
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "nat_gateway_public_ip_prefix" {
  for_each = var.public_ip_prefix_id_map

  nat_gateway_id      = azurerm_nat_gateway.nat_gateway.id
  public_ip_prefix_id = each.value
}
