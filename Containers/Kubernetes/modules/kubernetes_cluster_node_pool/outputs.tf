#############################################################################
# OUTPUT KUBERNETES CLUSTER NODE POOL
#############################################################################
output "id" {
  value = azurerm_kubernetes_cluster_node_pool.kubernetes_cluster_node_pool.id
}

output "name" {
  value = azurerm_kubernetes_cluster_node_pool.kubernetes_cluster_node_pool.name
}
