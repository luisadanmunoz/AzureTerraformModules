#############################################################################
# NAT GATEWAY
#############################################################################
resource "azurerm_nat_gateway" "nat_gateway" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"

  tags = var.tags

}
/*
#############################################################################
# NAT GATEWAY PUBLIC IP ASSOCIATION
#############################################################################
resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = var.public_ip_address_id
}

#############################################################################
# NAT GATEWAY SUBNET ASSOCIATION - 1
#############################################################################
resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association_1" {
  subnet_id      = var.subnet_id_1
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}
*/
#############################################################################
# NAT GATEWAY SUBNET ASSOCIATION - 2
#############################################################################
resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association_2" {
  subnet_id      = var.subnet_id_2
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}
#############################################################################
# NAT GATEWAY IP PREFIX
#############################################################################
resource "azurerm_public_ip_prefix" "public_ip_prefix" {
  name                = "public_ip_prefix"
  location            = var.location
  resource_group_name = var.resource_group_name
  prefix_length       = 31
  zones               = ["1", "2", "3"]
}
#############################################################################
# NAT GATEWAY IP PREFIX ASSOCIATION
#############################################################################
resource "azurerm_nat_gateway_public_ip_prefix_association" "nat_gateway_public_ip_prefix_association" {
  nat_gateway_id      = azurerm_nat_gateway.nat_gateway.id
  public_ip_prefix_id = azurerm_public_ip_prefix.public_ip_prefix.id
}


