################################################################################
# Arc Kubernetes Outputs
################################################################################

output "id" {
  description = "The ID of the Arc-enabled Kubernetes cluster."
  value       = var.create ? azurerm_arc_kubernetes_cluster.this[0].id : null
}

output "name" {
  description = "The name of the Arc-enabled Kubernetes cluster."
  value       = var.create ? azurerm_arc_kubernetes_cluster.this[0].name : null
}

output "identity" {
  description = "The identity block of the Arc-enabled Kubernetes cluster."
  value       = var.create ? azurerm_arc_kubernetes_cluster.this[0].identity : null
}

output "principal_id" {
  description = "The principal ID of the system-assigned managed identity."
  value       = var.create ? try(azurerm_arc_kubernetes_cluster.this[0].identity[0].principal_id, null) : null
}

output "agent_version" {
  description = "The version of the Arc agent."
  value       = var.create ? azurerm_arc_kubernetes_cluster.this[0].agent_version : null
}

output "distribution" {
  description = "The Kubernetes distribution running on this cluster."
  value       = var.create ? azurerm_arc_kubernetes_cluster.this[0].distribution : null
}

output "kubernetes_version" {
  description = "The Kubernetes version of the cluster."
  value       = var.create ? azurerm_arc_kubernetes_cluster.this[0].kubernetes_version : null
}

output "total_node_count" {
  description = "The total number of nodes in the cluster."
  value       = var.create ? azurerm_arc_kubernetes_cluster.this[0].total_node_count : null
}
