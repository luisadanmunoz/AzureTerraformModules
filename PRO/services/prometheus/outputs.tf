#############################################################################
# VIRTUAL MACHINE EXTENSION OUTPUT
#############################################################################
output "id" {
  value = azurerm_linux_virtual_machine.linux_vm_prometheus.id
}
output "name" {
  value = azurerm_linux_virtual_machine.linux_vm_prometheus.name
}