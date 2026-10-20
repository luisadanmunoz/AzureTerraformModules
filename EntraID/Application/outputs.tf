################################################################################
# Application Outputs
################################################################################

output "id" {
  description = "The Terraform resource ID of the application."
  value       = var.create ? azuread_application.this[0].id : null
}

output "object_id" {
  description = "The object ID of the application."
  value       = var.create ? azuread_application.this[0].object_id : null
}

output "application_id" {
  description = "The application ID (client ID) of the application."
  value       = var.create ? azuread_application.this[0].application_id : null
}

output "client_id" {
  description = "The client ID of the application (alias for application_id)."
  value       = var.create ? azuread_application.this[0].client_id : null
}

output "display_name" {
  description = "The display name of the application."
  value       = var.create ? azuread_application.this[0].display_name : null
}

output "publisher_domain" {
  description = "The verified publisher domain for the application."
  value       = var.create ? azuread_application.this[0].publisher_domain : null
}

output "disabled_by_microsoft" {
  description = "Whether Microsoft has disabled the registered application."
  value       = var.create ? azuread_application.this[0].disabled_by_microsoft : null
}

output "logo_url" {
  description = "CDN URL to the application's logo."
  value       = var.create ? azuread_application.this[0].logo_url : null
}

output "oauth2_permission_scope_ids" {
  description = "A map of OAuth2 permission scope values to scope IDs."
  value       = var.create ? azuread_application.this[0].oauth2_permission_scope_ids : null
}

output "app_role_ids" {
  description = "A map of app role values to app role IDs."
  value       = var.create ? azuread_application.this[0].app_role_ids : null
}
