# -----------------------------------------------------------------------------
# App Service Plan Outputs
# -----------------------------------------------------------------------------

output "id" {
  description = "The ID of the App Service Plan."
  value       = try(azurerm_service_plan.this[0].id, null)
}

output "name" {
  description = "The name of the App Service Plan."
  value       = try(azurerm_service_plan.this[0].name, null)
}

output "kind" {
  description = "The kind of the App Service Plan (e.g., 'linux', 'windows', 'elastic', 'functionapp')."
  value       = try(azurerm_service_plan.this[0].kind, null)
}

output "reserved" {
  description = "Whether this is a reserved (Linux) App Service Plan."
  value       = try(azurerm_service_plan.this[0].reserved, null)
}

output "os_type" {
  description = "The operating system type of the App Service Plan."
  value       = try(azurerm_service_plan.this[0].os_type, null)
}
