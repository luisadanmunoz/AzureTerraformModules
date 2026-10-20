#############################################################################
# PRIVATE DNS RESOLVER - FORWADING RULE
#############################################################################

module "forwarding_rule" {
  source = "./modules/forwarding_rule"

  for_each = var.forwarding_rule

  name_forwarding_rule = each.value["name_forwarding_rule"]
  //dns_forwarding_ruleset_id = "/subscriptions/7ce2dad1-eb7e-4709-ad81-0ad756dd943c/resourceGroups/rg-eu-west-pro-network-01/providers/Microsoft.Network/dnsForwardingRulesets/forwarding_ruleset"
  dns_forwarding_ruleset = element([for k, v in module.private_dns_resolver : v.ruleset_id if v.ruleset_name == each.value["dns_forwarding_ruleset"]], 0)
  domain_name            = each.value["domain_name"]
  enabled                = each.value["enabled"]
  ip_address             = each.value["ip_address"]
  port                   = each.value["port"]
  ip_address2            = each.value["ip_address2"]
  port2                  = each.value["port2"]

  depends_on = [module.private_dns_resolver]

}
