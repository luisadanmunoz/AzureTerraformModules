#############################################################################
# OUTPUT NAT GATEWAY
#############################################################################
output "id" {
  value = azurerm_nat_gateway.nat_gateway.id
}

output "name" {
  value = azurerm_nat_gateway.nat_gateway.name
}
