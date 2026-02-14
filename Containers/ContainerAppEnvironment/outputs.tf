################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Container App Environment."
  value       = var.create ? azurerm_container_app_environment.this[0].id : null
}

output "name" {
  description = "The name of the Container App Environment."
  value       = var.create ? azurerm_container_app_environment.this[0].name : null
}

output "default_domain" {
  description = "The default domain of the Container App Environment."
  value       = var.create ? azurerm_container_app_environment.this[0].default_domain : null
}

output "static_ip_address" {
  description = "The static IP address of the Container App Environment."
  value       = var.create ? azurerm_container_app_environment.this[0].static_ip_address : null
}

output "docker_bridge_cidr" {
  description = "The Docker bridge CIDR."
  value       = var.create ? azurerm_container_app_environment.this[0].docker_bridge_cidr : null
}

output "platform_reserved_cidr" {
  description = "The platform reserved CIDR."
  value       = var.create ? azurerm_container_app_environment.this[0].platform_reserved_cidr : null
}

output "platform_reserved_dns_ip_address" {
  description = "The platform reserved DNS IP address."
  value       = var.create ? azurerm_container_app_environment.this[0].platform_reserved_dns_ip_address : null
}

output "dapr_component_ids" {
  description = "Map of Dapr component names to their IDs."
  value       = var.create ? { for k, v in azurerm_container_app_environment_dapr_component.this : k => v.id } : {}
}

output "storage_ids" {
  description = "Map of storage names to their IDs."
  value       = var.create ? { for k, v in azurerm_container_app_environment_storage.this : k => v.id } : {}
}

output "certificate_ids" {
  description = "Map of certificate names to their IDs."
  value       = var.create ? { for k, v in azurerm_container_app_environment_certificate.this : k => v.id } : {}
}
