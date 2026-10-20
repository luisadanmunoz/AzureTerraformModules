################################################################################
# VPN Gateway Outputs
################################################################################

output "id" {
  description = "The ID of the VPN Gateway."
  value       = var.create ? azurerm_virtual_network_gateway.this[0].id : null
}

output "name" {
  description = "The name of the VPN Gateway."
  value       = var.create ? azurerm_virtual_network_gateway.this[0].name : null
}

output "public_ip_address" {
  description = "The primary public IP address."
  value       = local.create_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "public_ip_address_secondary" {
  description = "The secondary public IP address (active-active)."
  value       = local.create_public_ip_secondary ? azurerm_public_ip.secondary[0].ip_address : null
}

output "bgp_peering_address" {
  description = "BGP peering address."
  value       = var.create && var.enable_bgp ? azurerm_virtual_network_gateway.this[0].bgp_settings[0].peering_addresses : null
}

output "bgp_asn" {
  description = "BGP ASN."
  value       = var.create && var.enable_bgp && var.bgp_settings != null ? var.bgp_settings.asn : null
}
