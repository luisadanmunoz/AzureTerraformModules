#############################################################################
# PRIVATE DNS RESOLVER - FORWADING RULE
#############################################################################
resource "azurerm_private_dns_resolver_forwarding_rule" "forwarding_rule" {
  name                      = var.name_forwarding_rule
  dns_forwarding_ruleset_id = var.dns_forwarding_ruleset
  domain_name               = var.domain_name
  enabled                   = var.enabled
  target_dns_servers {
    ip_address = var.ip_address
    port       = var.port
  }
  target_dns_servers {
    ip_address = var.ip_address2
    port       = var.port2
  }
}