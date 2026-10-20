# #############################################################################
# PALO ALTO OUTPUT
# #############################################################################
output "id" {
  value = azurerm_network_interface.FW1_UNT_nic.id
}
output "name" {
  value = azurerm_network_interface.FW1_UNT_nic.name
}