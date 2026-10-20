#############################################################################
# LOG ANALYTICS WORKSPACE OUTPUT
#############################################################################
output "id" {
  description = "value of the id tag"
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.id
}
output "name" {
  description = "value of the name tag"
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.name
}