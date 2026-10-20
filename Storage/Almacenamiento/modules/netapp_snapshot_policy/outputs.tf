#############################################################################
# OUTPUT NETAPP SNAPSHOT POLICY
#############################################################################
output "id" {
  value = azurerm_netapp_snapshot_policy.netapp_snapshot_policy.id
}

output "name" {
  value = azurerm_netapp_snapshot_policy.netapp_snapshot_policy.name
}
