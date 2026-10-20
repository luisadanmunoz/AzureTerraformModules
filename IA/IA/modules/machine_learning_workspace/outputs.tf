#############################################################################
# OUTPUT MACHINE LEARNING WORKSPACE
#############################################################################
output "id" {
  value = azurerm_machine_learning_workspace.machine_learning_workspace.id
}

output "name" {
  value = azurerm_machine_learning_workspace.machine_learning_workspace.name
}

output "workspace_id" {
  value = azurerm_machine_learning_workspace.machine_learning_workspace.workspace_id
}
