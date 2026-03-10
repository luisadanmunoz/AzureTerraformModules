################################################################################
# Static Web App Outputs
################################################################################

output "id" {
  description = "The ID of the Static Web App."
  value       = var.create ? azurerm_static_web_app.this[0].id : null
}

output "name" {
  description = "The name of the Static Web App."
  value       = var.create ? azurerm_static_web_app.this[0].name : null
}

output "default_host_name" {
  description = "The default hostname of the Static Web App."
  value       = var.create ? azurerm_static_web_app.this[0].default_host_name : null
}

output "api_key" {
  description = "The API key for deployment."
  value       = var.create ? azurerm_static_web_app.this[0].api_key : null
  sensitive   = true
}

output "principal_id" {
  description = "The principal ID of the system-assigned identity."
  value       = var.create ? try(azurerm_static_web_app.this[0].identity[0].principal_id, null) : null
}
