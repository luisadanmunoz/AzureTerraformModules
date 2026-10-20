module "private_dns_resolver" {
  source = "./modules/private_dns_resolver"

  for_each = var.private_dns_resolver
  #############################################################################
  # PRIVATE DNS RESOLVER
  #############################################################################
  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]
  name_outbound       = each.value["name_outbound"]
  virtual_network_id  = element([for k, v in module.vnet : v.id if v.name == each.value["virtual_network"]], 0)
  #############################################################################
  # PRIVATE DNS RESOLVER - OUTBOUND ENDPOINT
  #############################################################################
  subnet_id_outbound = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_name_outbound"]], 0)
  #############################################################################
  # PRIVATE DNS RESOLVER - INBOUND ENDPOINT
  #############################################################################
  name_inbound      = each.value["name_inbound"]
  private_ip        = each.value["private_ip"]
  subnet_id_inbound = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_name_inbound"]], 0)
  #############################################################################
  # PRIVATE DNS RESOLVER - FORWARDING RULESET
  #############################################################################
  name_forwarding_ruleset = each.value["name_forwarding_ruleset"]
  #############################################################################
  # PRIVATE DNS RESOLVER - NETWORK LINK
  #############################################################################
  name_virtual_network_link = each.value["name_virtual_network_link"]

  depends_on = [module.subnet]

  tags = var.tags
}