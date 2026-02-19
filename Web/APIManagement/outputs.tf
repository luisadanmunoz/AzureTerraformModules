################################################################################
# API Management Outputs
################################################################################

output "id" {
  description = "The ID of the API Management service."
  value       = var.create ? azurerm_api_management.this[0].id : null
}

output "name" {
  description = "The name of the API Management service."
  value       = var.create ? azurerm_api_management.this[0].name : null
}

output "gateway_url" {
  description = "The gateway URL of the API Management service."
  value       = var.create ? azurerm_api_management.this[0].gateway_url : null
}

output "gateway_regional_url" {
  description = "The regional gateway URL."
  value       = var.create ? azurerm_api_management.this[0].gateway_regional_url : null
}

output "management_api_url" {
  description = "The management API URL."
  value       = var.create ? azurerm_api_management.this[0].management_api_url : null
}

output "portal_url" {
  description = "The publisher portal URL."
  value       = var.create ? azurerm_api_management.this[0].portal_url : null
}

output "developer_portal_url" {
  description = "The developer portal URL."
  value       = var.create ? azurerm_api_management.this[0].developer_portal_url : null
}

output "public_ip_addresses" {
  description = "The public IP addresses of the API Management service."
  value       = var.create ? azurerm_api_management.this[0].public_ip_addresses : null
}

output "private_ip_addresses" {
  description = "The private IP addresses of the API Management service."
  value       = var.create ? azurerm_api_management.this[0].private_ip_addresses : null
}

output "principal_id" {
  description = "The principal ID of the system-assigned identity."
  value       = var.create ? try(azurerm_api_management.this[0].identity[0].principal_id, null) : null
}
