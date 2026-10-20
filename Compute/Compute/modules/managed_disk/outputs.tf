#############################################################################
# OUTPUT MANAGED DISK
#############################################################################
output "id" {
  value = azurerm_managed_disk.managed_disk.id
}

output "name" {
  value = azurerm_managed_disk.managed_disk.name
}
