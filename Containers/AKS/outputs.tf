################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the AKS cluster."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].id : null
}

output "name" {
  description = "The name of the AKS cluster."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].name : null
}

output "fqdn" {
  description = "The FQDN of the AKS cluster."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].fqdn : null
}

output "private_fqdn" {
  description = "The private FQDN of the AKS cluster (if private)."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].private_fqdn : null
}

output "kube_config" {
  description = "The Kubernetes config for the cluster."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].kube_config : null
  sensitive   = true
}

output "kube_config_raw" {
  description = "The raw Kubernetes config."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].kube_config_raw : null
  sensitive   = true
}

output "kube_admin_config" {
  description = "The admin Kubernetes config."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].kube_admin_config : null
  sensitive   = true
}

output "host" {
  description = "The Kubernetes API server host."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].kube_config[0].host : null
  sensitive   = true
}

output "client_certificate" {
  description = "The client certificate for authentication."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].kube_config[0].client_certificate : null
  sensitive   = true
}

output "client_key" {
  description = "The client key for authentication."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].kube_config[0].client_key : null
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "The cluster CA certificate."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].kube_config[0].cluster_ca_certificate : null
  sensitive   = true
}

output "identity" {
  description = "The identity of the AKS cluster."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].identity : null
}

output "kubelet_identity" {
  description = "The kubelet identity of the AKS cluster."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].kubelet_identity : null
}

output "node_resource_group" {
  description = "The auto-generated resource group for nodes."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].node_resource_group : null
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL for workload identity."
  value       = var.create ? azurerm_kubernetes_cluster.this[0].oidc_issuer_url : null
}

output "node_pool_ids" {
  description = "IDs of additional node pools."
  value       = var.create ? { for k, v in azurerm_kubernetes_cluster_node_pool.this : k => v.id } : {}
}
