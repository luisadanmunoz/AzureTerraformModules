################################################################################
# Private Endpoint Outputs
################################################################################

output "id" {
  description = "The ID of the Private Endpoint."
  value       = var.create ? azurerm_private_endpoint.this[0].id : null
}

output "name" {
  description = "The name of the Private Endpoint."
  value       = var.create ? azurerm_private_endpoint.this[0].name : null
}

output "resource_group_name" {
  description = "The name of the Resource Group."
  value       = var.create ? azurerm_private_endpoint.this[0].resource_group_name : null
}

output "subnet_id" {
  description = "The ID of the Subnet."
  value       = var.create ? azurerm_private_endpoint.this[0].subnet_id : null
}

output "private_ip_address" {
  description = "The private IP address of the Private Endpoint."
  value       = var.create ? azurerm_private_endpoint.this[0].private_service_connection[0].private_ip_address : null
}

output "private_ip_addresses" {
  description = "All private IP addresses of the Private Endpoint."
  value       = var.create ? azurerm_private_endpoint.this[0].custom_dns_configs[*].ip_addresses : null
}

output "fqdn" {
  description = "The FQDNs from custom DNS configs."
  value       = var.create ? azurerm_private_endpoint.this[0].custom_dns_configs[*].fqdn : null
}

output "network_interface_id" {
  description = "The ID of the network interface."
  value       = var.create ? azurerm_private_endpoint.this[0].network_interface[0].id : null
}

output "network_interface_name" {
  description = "The name of the network interface."
  value       = var.create ? azurerm_private_endpoint.this[0].network_interface[0].name : null
}
