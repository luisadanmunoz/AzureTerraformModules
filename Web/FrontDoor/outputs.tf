################################################################################
# Front Door Profile Outputs
################################################################################

output "id" {
  description = "The ID of the Front Door Profile."
  value       = var.create ? azurerm_cdn_frontdoor_profile.this[0].id : null
}

output "name" {
  description = "The name of the Front Door Profile."
  value       = var.create ? azurerm_cdn_frontdoor_profile.this[0].name : null
}

output "resource_guid" {
  description = "The UUID of the Front Door Profile."
  value       = var.create ? azurerm_cdn_frontdoor_profile.this[0].resource_guid : null
}
