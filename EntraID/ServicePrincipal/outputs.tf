################################################################################
# Service Principal Outputs
################################################################################

output "id" {
  description = "The Terraform resource ID of the service principal."
  value       = var.use_existing ? data.azuread_service_principal.this[0].id : (var.create ? azuread_service_principal.this[0].id : null)
}

output "object_id" {
  description = "The object ID of the service principal."
  value       = var.use_existing ? data.azuread_service_principal.this[0].object_id : (var.create ? azuread_service_principal.this[0].object_id : null)
}

output "application_id" {
  description = "The application ID (client ID) of the associated application."
  value       = var.use_existing ? data.azuread_service_principal.this[0].client_id : (var.create ? azuread_service_principal.this[0].client_id : null)
}

output "display_name" {
  description = "The display name of the service principal."
  value       = var.use_existing ? data.azuread_service_principal.this[0].display_name : (var.create ? azuread_service_principal.this[0].display_name : null)
}

output "app_roles" {
  description = "The app roles published by the associated application."
  value       = var.use_existing ? data.azuread_service_principal.this[0].app_roles : (var.create ? azuread_service_principal.this[0].app_roles : null)
}

output "app_role_ids" {
  description = "A map of app role values to app role IDs."
  value       = var.use_existing ? data.azuread_service_principal.this[0].app_role_ids : (var.create ? azuread_service_principal.this[0].app_role_ids : null)
}

output "oauth2_permission_scopes" {
  description = "The OAuth 2.0 permission scopes published by the associated application."
  value       = var.use_existing ? data.azuread_service_principal.this[0].oauth2_permission_scopes : (var.create ? azuread_service_principal.this[0].oauth2_permission_scopes : null)
}

output "oauth2_permission_scope_ids" {
  description = "A map of OAuth 2.0 permission scope values to scope IDs."
  value       = var.use_existing ? data.azuread_service_principal.this[0].oauth2_permission_scope_ids : (var.create ? azuread_service_principal.this[0].oauth2_permission_scope_ids : null)
}

output "homepage_url" {
  description = "The home page URL of the service principal."
  value       = var.use_existing ? data.azuread_service_principal.this[0].homepage_url : (var.create ? azuread_service_principal.this[0].homepage_url : null)
}

output "logout_url" {
  description = "The logout URL of the service principal."
  value       = var.use_existing ? data.azuread_service_principal.this[0].logout_url : (var.create ? azuread_service_principal.this[0].logout_url : null)
}

output "redirect_uris" {
  description = "The redirect URIs of the service principal."
  value       = var.use_existing ? data.azuread_service_principal.this[0].redirect_uris : (var.create ? azuread_service_principal.this[0].redirect_uris : null)
}

output "saml_metadata_url" {
  description = "The URL where the service exposes SAML metadata for federation."
  value       = var.use_existing ? data.azuread_service_principal.this[0].saml_metadata_url : (var.create ? azuread_service_principal.this[0].saml_metadata_url : null)
}

output "service_principal_names" {
  description = "A list of identifier URIs for the service principal."
  value       = var.use_existing ? data.azuread_service_principal.this[0].service_principal_names : (var.create ? azuread_service_principal.this[0].service_principal_names : null)
}

output "sign_in_audience" {
  description = "The Microsoft account types supported for the associated application."
  value       = var.use_existing ? data.azuread_service_principal.this[0].sign_in_audience : (var.create ? azuread_service_principal.this[0].sign_in_audience : null)
}

output "type" {
  description = "The type of the service principal."
  value       = var.use_existing ? data.azuread_service_principal.this[0].type : (var.create ? azuread_service_principal.this[0].type : null)
}
