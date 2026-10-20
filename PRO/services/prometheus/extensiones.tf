#############################################################################
# VIRTUAL MACHINE EXTENSION - AMA
#############################################################################
resource "azurerm_virtual_machine_extension" "ama" {
  name                       = "AzureMonitorLinuxAgent"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.28"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux_vm_prometheus.id

  depends_on = [azurerm_linux_virtual_machine.linux_vm_prometheus]
}
#############################################################################
# VIRTUAL MACHINE EXTENSION - DA
#############################################################################
resource "azurerm_virtual_machine_extension" "da" {
  name                       = "DependencyAgentLinux"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  settings                   = jsonencode({ "enableAMA" = "true" })
  type                       = "DependencyAgentLinux"
  type_handler_version       = "9.10"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux_vm_prometheus.id

  depends_on = [azurerm_linux_virtual_machine.linux_vm_prometheus]

}
