#############################################################################
# PRIVATE DNS RESOLVER
#############################################################################
output "private_dns_resolver_id" {
  value = azurerm_private_dns_resolver.private_dns_resolver.id
}
#############################################################################
# PRIVATE DNS RESOLVER - INBOUND ENDPOINT
#############################################################################
output "private_dns_resolver_inbound_endpoint_id" {
  value = azurerm_private_dns_resolver_outbound_endpoint.outbound_endpoint.id
}
#############################################################################
# PRIVATE DNS RESOLVER - NETWORK LINK
#############################################################################
output "private_dns_resolver_virtual_network_link" {
  value = azurerm_private_dns_resolver_dns_forwarding_ruleset.forwarding_ruleset.id
}
#############################################################################
# PRIVATE DNS RESOLVER - FORWARDING RULESET
#############################################################################
output "ruleset_id" {
  value = azurerm_private_dns_resolver_dns_forwarding_ruleset.forwarding_ruleset.id
}
output "ruleset_name" {
  value = azurerm_private_dns_resolver_dns_forwarding_ruleset.forwarding_ruleset.name
}