#############################################################################
# OUTPUT MACHINE LEARNING INFERENCE CLUSTER
#############################################################################
output "id" {
  value = azurerm_machine_learning_inference_cluster.machine_learning_inference_cluster.id
}

output "name" {
  value = azurerm_machine_learning_inference_cluster.machine_learning_inference_cluster.name
}
