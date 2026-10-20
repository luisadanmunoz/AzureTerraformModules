#############################################################################
# OUTPUT SENTINEL LOG ANALYTICS WORKSPACE ONBOARDING
#############################################################################
output "id" {
  value = azurerm_sentinel_log_analytics_workspace_onboarding.sentinel_log_analytics_workspace_onboarding.id
}

output "workspace_id" {
  value = var.workspace_id
}
