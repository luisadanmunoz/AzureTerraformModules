################################################################################
# ML Workspace Outputs
################################################################################

output "id" {
  description = "The ID of the ML Workspace."
  value       = var.create ? azurerm_machine_learning_workspace.this[0].id : null
}

output "name" {
  description = "The name of the ML Workspace."
  value       = var.create ? azurerm_machine_learning_workspace.this[0].name : null
}

output "discovery_url" {
  description = "The discovery URL of the workspace."
  value       = var.create ? azurerm_machine_learning_workspace.this[0].discovery_url : null
}

output "workspace_id" {
  description = "The workspace ID."
  value       = var.create ? azurerm_machine_learning_workspace.this[0].workspace_id : null
}

output "identity" {
  description = "The identity block."
  value       = var.create ? azurerm_machine_learning_workspace.this[0].identity : null
}

output "principal_id" {
  description = "The principal ID of the system-assigned identity."
  value       = var.create ? try(azurerm_machine_learning_workspace.this[0].identity[0].principal_id, null) : null
}
