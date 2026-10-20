#############################################################################
# OUTPUT NETAPP ACCOUNT
#############################################################################
output "id" {
  value = azurerm_netapp_account.netapp_account.id
}

output "name" {
  value = azurerm_netapp_account.netapp_account.name
}
