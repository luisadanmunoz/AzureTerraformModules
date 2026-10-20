#############################################################################
# OUTPUT MACHINE LEARNING COMPUTE CLUSTER
#############################################################################
output "id" {
  value = azurerm_machine_learning_compute_cluster.machine_learning_compute_cluster.id
}

output "name" {
  value = azurerm_machine_learning_compute_cluster.machine_learning_compute_cluster.name
}
