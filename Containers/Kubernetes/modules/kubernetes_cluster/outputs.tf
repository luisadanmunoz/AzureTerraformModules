#############################################################################
# OUTPUT KUBERNETES CLUSTER
#############################################################################
output "id" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.id
}

output "name" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.name
}

output "fqdn" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.fqdn
}

output "private_fqdn" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.private_fqdn
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.node_resource_group
}

output "current_kubernetes_version" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.current_kubernetes_version
}

output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.oidc_issuer_url
}
