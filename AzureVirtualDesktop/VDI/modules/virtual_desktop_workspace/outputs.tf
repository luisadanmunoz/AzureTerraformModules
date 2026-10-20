#############################################################################
# OUTPUT VIRTUAL DESKTOP WORKSPACE
#############################################################################
output "id" {
  value = azurerm_virtual_desktop_workspace.virtual_desktop_workspace.id
}

output "name" {
  value = azurerm_virtual_desktop_workspace.virtual_desktop_workspace.name
}
