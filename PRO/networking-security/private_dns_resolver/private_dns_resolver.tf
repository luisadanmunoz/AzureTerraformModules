#############################################################################
# PRIVATE DNS RESOLVER
#############################################################################
resource "azurerm_private_dns_resolver" "private_dns_resolver" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
  tags                = var.tags

}
#############################################################################
# PRIVATE DNS RESOLVER - OUTBOUND ENDPOINT
#############################################################################
resource "azurerm_private_dns_resolver_outbound_endpoint" "outbound_endpoint" {
  name                    = var.name_outbound
  private_dns_resolver_id = azurerm_private_dns_resolver.private_dns_resolver.id
  location                = var.location
  subnet_id               = var.subnet_id_outbound
  depends_on = [
    azurerm_private_dns_resolver.private_dns_resolver
  ]

  tags = var.tags

}
#############################################################################
# PRIVATE DNS RESOLVER - INBOUND ENDPOINT
#############################################################################
resource "azurerm_private_dns_resolver_inbound_endpoint" "inbound_endpoint" {
  name                    = var.name_inbound
  private_dns_resolver_id = azurerm_private_dns_resolver.private_dns_resolver.id
  location                = var.location

  ip_configurations {
    private_ip_allocation_method = var.private_ip
    subnet_id                    = var.subnet_id_inbound
  }
  depends_on = [
    azurerm_private_dns_resolver.private_dns_resolver
  ]

  tags = var.tags

}
#############################################################################
# PRIVATE DNS RESOLVER - FORWARDING RULESET
#############################################################################
resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "forwarding_ruleset" {
  name                                       = var.name_forwarding_ruleset
  resource_group_name                        = var.resource_group_name
  location                                   = var.location
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.outbound_endpoint.id]
  depends_on = [
    azurerm_private_dns_resolver_outbound_endpoint.outbound_endpoint
  ]

  tags = var.tags

}
#############################################################################
# PRIVATE DNS RESOLVER - NETWORK LINK
#############################################################################
resource "azurerm_private_dns_resolver_virtual_network_link" "network_link" {
  name                      = var.name_virtual_network_link
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.forwarding_ruleset.id
  virtual_network_id        = var.virtual_network_id

  depends_on = [
    azurerm_private_dns_resolver_dns_forwarding_ruleset.forwarding_ruleset
  ]
}