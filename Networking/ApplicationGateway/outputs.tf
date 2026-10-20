################################################################################
# Application Gateway Outputs
################################################################################

output "id" {
  description = "The ID of the Application Gateway."
  value       = var.create ? azurerm_application_gateway.this[0].id : null
}

output "name" {
  description = "The name of the Application Gateway."
  value       = var.create ? azurerm_application_gateway.this[0].name : null
}

output "public_ip_address" {
  description = "The public IP address of the Application Gateway."
  value       = local.create_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "public_ip_id" {
  description = "The ID of the public IP (if created)."
  value       = local.create_public_ip ? azurerm_public_ip.this[0].id : var.public_ip_id
}

output "private_ip_address" {
  description = "The private IP address of the Application Gateway."
  value       = var.create && var.private_ip_address != null ? var.private_ip_address : null
}

output "backend_address_pools" {
  description = "Backend address pool IDs."
  value       = var.create ? { for pool in azurerm_application_gateway.this[0].backend_address_pool : pool.name => pool.id } : {}
}

output "frontend_ip_configuration" {
  description = "Frontend IP configuration."
  value       = var.create ? azurerm_application_gateway.this[0].frontend_ip_configuration : null
}
