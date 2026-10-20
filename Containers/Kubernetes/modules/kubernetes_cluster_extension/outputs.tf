#############################################################################
# OUTPUT KUBERNETES CLUSTER EXTENSION
#############################################################################
output "id" {
  value = azurerm_kubernetes_cluster_extension.kubernetes_cluster_extension.id
}

output "name" {
  value = azurerm_kubernetes_cluster_extension.kubernetes_cluster_extension.name
}
