################################################################################
# Route Server Outputs
################################################################################

output "id" {
  description = "The ID of the Route Server."
  value       = var.create ? azurerm_route_server.this[0].id : null
}

output "name" {
  description = "The name of the Route Server."
  value       = var.create ? azurerm_route_server.this[0].name : null
}

output "virtual_router_asn" {
  description = "The ASN of the Route Server virtual router."
  value       = var.create ? azurerm_route_server.this[0].virtual_router_asn : null
}

output "virtual_router_ips" {
  description = "The IP addresses of the Route Server virtual router (BGP peering endpoints)."
  value       = var.create ? azurerm_route_server.this[0].virtual_router_ips : null
}

################################################################################
# Public IP Outputs
################################################################################

output "public_ip_id" {
  description = "The ID of the created Public IP (if created by the module)."
  value       = var.create && var.public_ip_address_id == null ? azurerm_public_ip.this[0].id : null
}

output "public_ip_address" {
  description = "The IP address of the created Public IP (if created by the module)."
  value       = var.create && var.public_ip_address_id == null ? azurerm_public_ip.this[0].ip_address : null
}
