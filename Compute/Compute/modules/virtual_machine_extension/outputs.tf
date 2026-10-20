#############################################################################
# OUTPUT VIRTUAL MACHINE EXTENSION
#############################################################################
output "id" {
  value = azurerm_virtual_machine_extension.virtual_machine_extension.id
}

output "name" {
  value = azurerm_virtual_machine_extension.virtual_machine_extension.name
}
