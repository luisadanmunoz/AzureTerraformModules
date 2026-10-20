#############################################################################
# OUTPUT LOG ANALYTICS WORKSPACE
#############################################################################
output "id" {
  value = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

output "name" {
  value = azurerm_log_analytics_workspace.log_analytics_workspace.name
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
}
