#############################################################################
# OUTPUT VIRTUAL DESKTOP HOST POOL
#############################################################################
output "id" {
  value = azurerm_virtual_desktop_host_pool.virtual_desktop_host_pool.id
}

output "name" {
  value = azurerm_virtual_desktop_host_pool.virtual_desktop_host_pool.name
}
