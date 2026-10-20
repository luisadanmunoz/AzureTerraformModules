#############################################################################
# OUTPUT WINDOWS VIRTUAL MACHINE
#############################################################################
output "id" {
  value = azurerm_windows_virtual_machine.windows_virtual_machine.id
}

output "name" {
  value = azurerm_windows_virtual_machine.windows_virtual_machine.name
}

output "virtual_machine_id" {
  value = azurerm_windows_virtual_machine.windows_virtual_machine.virtual_machine_id
}

output "os_managed_disk_id" {
  value = azurerm_windows_virtual_machine.windows_virtual_machine.os_managed_disk_id
}

output "private_ip_address" {
  value = azurerm_windows_virtual_machine.windows_virtual_machine.private_ip_address
}

output "public_ip_address" {
  value = azurerm_windows_virtual_machine.windows_virtual_machine.public_ip_address
}
