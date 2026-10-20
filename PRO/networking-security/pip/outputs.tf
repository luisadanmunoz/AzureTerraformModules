# #############################################################################
# PUBLIC IP OUTPUTS
# #############################################################################
output "id" {
  value = azurerm_public_ip.public_ip.id
}
output "name" {
  value = azurerm_public_ip.public_ip.name
}