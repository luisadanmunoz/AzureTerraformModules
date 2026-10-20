resource "azurerm_virtual_machine_extension" "ama" {
  name                       = "AzureMonitorLinuxAgent"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent" //PROBAR
  type_handler_version       = "1.20"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux_vm.id

  depends_on = [azurerm_linux_virtual_machine.linux_vm]

}