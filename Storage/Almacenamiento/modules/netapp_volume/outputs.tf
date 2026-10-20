#############################################################################
# OUTPUT NETAPP VOLUME
#############################################################################
output "id" {
  value = azurerm_netapp_volume.netapp_volume.id
}

output "name" {
  value = azurerm_netapp_volume.netapp_volume.name
}

output "mount_ip_addresses" {
  value = azurerm_netapp_volume.netapp_volume.mount_ip_addresses
}
