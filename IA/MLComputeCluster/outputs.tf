################################################################################
# ML Compute Cluster Outputs
################################################################################

output "id" {
  description = "The ID of the compute cluster."
  value       = var.create ? azurerm_machine_learning_compute_cluster.this[0].id : null
}

output "name" {
  description = "The name of the compute cluster."
  value       = var.create ? azurerm_machine_learning_compute_cluster.this[0].name : null
}

output "identity" {
  description = "The identity block."
  value       = var.create ? azurerm_machine_learning_compute_cluster.this[0].identity : null
}

output "principal_id" {
  description = "The principal ID of the system-assigned identity."
  value       = var.create ? try(azurerm_machine_learning_compute_cluster.this[0].identity[0].principal_id, null) : null
}
