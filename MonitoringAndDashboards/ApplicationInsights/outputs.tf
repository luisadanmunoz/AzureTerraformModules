# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------

output "id" {
  description = "The ID of the Application Insights resource."
  value       = try(azurerm_application_insights.this[0].id, null)
}

output "name" {
  description = "The name of the Application Insights resource."
  value       = try(azurerm_application_insights.this[0].name, null)
}

output "app_id" {
  description = "The App ID associated with this Application Insights resource."
  value       = try(azurerm_application_insights.this[0].app_id, null)
}

output "instrumentation_key" {
  description = "The Instrumentation Key for this Application Insights resource."
  value       = try(azurerm_application_insights.this[0].instrumentation_key, null)
  sensitive   = true
}

output "connection_string" {
  description = "The Connection String for this Application Insights resource."
  value       = try(azurerm_application_insights.this[0].connection_string, null)
  sensitive   = true
}
