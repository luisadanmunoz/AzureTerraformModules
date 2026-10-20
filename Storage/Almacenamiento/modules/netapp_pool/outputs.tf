#############################################################################
# OUTPUT NETAPP POOL
#############################################################################
output "id" {
  value = azurerm_netapp_pool.netapp_pool.id
}

output "name" {
  value = azurerm_netapp_pool.netapp_pool.name
}
