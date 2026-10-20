################################################################################
# CDN Profile Outputs
################################################################################

output "id" {
  description = "The ID of the CDN Profile."
  value       = var.create ? azurerm_cdn_profile.this[0].id : null
}

output "name" {
  description = "The name of the CDN Profile."
  value       = var.create ? azurerm_cdn_profile.this[0].name : null
}
