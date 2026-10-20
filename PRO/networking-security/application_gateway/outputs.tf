#############################################################################
# APPLICATION GATEWAY OUTPUT
#############################################################################
output "id" {
  value = azurerm_application_gateway.agw.id
}
output "name" {
  value = azurerm_application_gateway.agw.name
}