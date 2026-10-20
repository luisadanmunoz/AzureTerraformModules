#############################################################################
# OUTPUT KUBERNETES CLUSTER TRUSTED ACCESS ROLE BINDING
#############################################################################
output "id" {
  value = azurerm_kubernetes_cluster_trusted_access_role_binding.kubernetes_cluster_trusted_access_role_binding.id
}

output "name" {
  value = azurerm_kubernetes_cluster_trusted_access_role_binding.kubernetes_cluster_trusted_access_role_binding.name
}
