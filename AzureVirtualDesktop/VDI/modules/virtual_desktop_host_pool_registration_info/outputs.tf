#############################################################################
# OUTPUT VIRTUAL DESKTOP HOST POOL REGISTRATION INFO
#############################################################################
output "id" {
  value = azurerm_virtual_desktop_host_pool_registration_info.virtual_desktop_host_pool_registration_info.id
}

output "token" {
  value     = azurerm_virtual_desktop_host_pool_registration_info.virtual_desktop_host_pool_registration_info.token
  sensitive = true
}
