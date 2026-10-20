#############################################################################
# OUTPUT KUBERNETES FLEET MANAGER
#############################################################################
output "id" {
  value = azurerm_kubernetes_fleet_manager.kubernetes_fleet_manager.id
}

output "name" {
  value = azurerm_kubernetes_fleet_manager.kubernetes_fleet_manager.name
}
