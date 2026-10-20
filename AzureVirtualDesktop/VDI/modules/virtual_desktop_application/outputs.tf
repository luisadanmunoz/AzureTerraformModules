#############################################################################
# OUTPUT VIRTUAL DESKTOP APPLICATION
#############################################################################
output "id" {
  value = azurerm_virtual_desktop_application.virtual_desktop_application.id
}

output "name" {
  value = azurerm_virtual_desktop_application.virtual_desktop_application.name
}
