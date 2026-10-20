################################################################################
# Bastion Host Outputs
################################################################################

output "id" {
  description = "The ID of the Bastion Host."
  value       = var.create ? azurerm_bastion_host.this[0].id : null
}

output "name" {
  description = "The name of the Bastion Host."
  value       = var.create ? azurerm_bastion_host.this[0].name : null
}

output "dns_name" {
  description = "The DNS name of the Bastion Host."
  value       = var.create ? azurerm_bastion_host.this[0].dns_name : null
}

output "public_ip_address" {
  description = "The public IP address of the Bastion Host."
  value       = local.create_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "public_ip_id" {
  description = "The ID of the Public IP."
  value       = local.create_public_ip ? azurerm_public_ip.this[0].id : var.public_ip_id
}
