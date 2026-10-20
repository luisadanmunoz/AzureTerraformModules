#############################################################################
# OUTPUT MACHINE LEARNING COMPUTE INSTANCE
#############################################################################
output "id" {
  value = azurerm_machine_learning_compute_instance.machine_learning_compute_instance.id
}

output "name" {
  value = azurerm_machine_learning_compute_instance.machine_learning_compute_instance.name
}
