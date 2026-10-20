################################################################################
# ML Compute Instance Outputs
################################################################################

output "id" {
  description = "The ID of the compute instance."
  value       = var.create ? azurerm_machine_learning_compute_instance.this[0].id : null
}

output "name" {
  description = "The name of the compute instance."
  value       = var.create ? azurerm_machine_learning_compute_instance.this[0].name : null
}
