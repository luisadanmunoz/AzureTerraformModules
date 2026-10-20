#############################################################################
# OUTPUT KUBERNETES FLEET MEMBER
#############################################################################
output "id" {
  value = azurerm_kubernetes_fleet_member.kubernetes_fleet_member.id
}

output "name" {
  value = azurerm_kubernetes_fleet_member.kubernetes_fleet_member.name
}
