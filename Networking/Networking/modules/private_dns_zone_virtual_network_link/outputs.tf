#############################################################################
# OUTPUT PRIVATE DNS ZONE VIRTUAL NETWORK LINK
#############################################################################
output "id" {
  value = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link.id
}

output "name" {
  value = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link.name
}
