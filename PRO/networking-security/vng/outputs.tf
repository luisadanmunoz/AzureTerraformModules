#############################################################################
# VIRTUAL NETWORK GATEWAY OUTPUT
#############################################################################
output "id" {
  value = azurerm_virtual_network_gateway.vng.id
}
output "name" {
  value = azurerm_virtual_network_gateway.vng.name
}