################################################################################
# Virtual WAN Outputs
################################################################################

output "id" {
  description = "The ID of the Virtual WAN."
  value       = var.create ? azurerm_virtual_wan.this[0].id : null
}

output "name" {
  description = "The name of the Virtual WAN."
  value       = var.create ? azurerm_virtual_wan.this[0].name : null
}

output "virtual_hub_ids" {
  description = "Map of Virtual Hub IDs keyed by index."
  value       = var.create ? { for key, hub in azurerm_virtual_hub.this : key => hub.id } : {}
}

output "vpn_gateway_ids" {
  description = "Map of VPN Gateway IDs keyed by index."
  value       = var.create ? { for key, gw in azurerm_vpn_gateway.this : key => gw.id } : {}
}
