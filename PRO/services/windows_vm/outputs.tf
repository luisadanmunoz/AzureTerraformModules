#############################################################################
# WINDOWS VIRTUAL MACHINE OUTPUT
#############################################################################
output "id" {
  value = azurerm_windows_virtual_machine.vm.id
}
output "name" {
  value = azurerm_windows_virtual_machine.vm.name
}
output "size" {
  value = azurerm_windows_virtual_machine.vm.size
}