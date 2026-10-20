################################################################################
# Front Door Profile Outputs
################################################################################

output "profile_id" {
  description = "The ID of the Front Door profile."
  value       = var.create ? azurerm_cdn_frontdoor_profile.this[0].id : null
}

output "profile_name" {
  description = "The name of the Front Door profile."
  value       = var.create ? azurerm_cdn_frontdoor_profile.this[0].name : null
}

output "resource_guid" {
  description = "The UUID of the Front Door profile."
  value       = var.create ? azurerm_cdn_frontdoor_profile.this[0].resource_guid : null
}

################################################################################
# Endpoint Outputs
################################################################################

output "endpoint_ids" {
  description = "Map of endpoint names to their resource IDs."
  value       = var.create ? { for k, ep in azurerm_cdn_frontdoor_endpoint.this : k => ep.id } : {}
}

output "endpoint_host_names" {
  description = "Map of endpoint names to their host names (.azurefd.net)."
  value       = var.create ? { for k, ep in azurerm_cdn_frontdoor_endpoint.this : k => ep.host_name } : {}
}

################################################################################
# Origin Group Outputs
################################################################################

output "origin_group_ids" {
  description = "Map of origin group names to their resource IDs."
  value       = var.create ? { for k, og in azurerm_cdn_frontdoor_origin_group.this : k => og.id } : {}
}

################################################################################
# Origin Outputs
################################################################################

output "origin_ids" {
  description = "Map of origin names to their resource IDs."
  value       = var.create ? { for k, o in azurerm_cdn_frontdoor_origin.this : k => o.id } : {}
}

################################################################################
# Route Outputs
################################################################################

output "route_ids" {
  description = "Map of route names to their resource IDs."
  value       = var.create ? { for k, r in azurerm_cdn_frontdoor_route.this : k => r.id } : {}
}

################################################################################
# Custom Domain Outputs
################################################################################

output "custom_domain_ids" {
  description = "Map of custom domain names to their resource IDs."
  value       = var.create ? { for k, cd in azurerm_cdn_frontdoor_custom_domain.this : k => cd.id } : {}
}

output "custom_domain_validation_tokens" {
  description = "Map of custom domain names to their DNS validation tokens."
  value       = var.create ? { for k, cd in azurerm_cdn_frontdoor_custom_domain.this : k => cd.validation_token } : {}
}

################################################################################
# Security Policy Outputs
################################################################################

output "security_policy_ids" {
  description = "Map of security policy names to their resource IDs."
  value       = var.create ? { for k, sp in azurerm_cdn_frontdoor_security_policy.this : k => sp.id } : {}
}
