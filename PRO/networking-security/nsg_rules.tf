#############################################################################
# NETWORK SECURITY RULES
############################################################################# 
module "nsg_rules" {
  source = "./modules/nsg_rules"

  for_each = var.nsg_rules

  name_rule                                  = each.value["name_rule"]
  direction                                  = each.value["direction"]
  access                                     = each.value["access"]
  priority                                   = each.value["priority"]
  protocol                                   = each.value["protocol"]
  resource_group_name                        = each.value["resource_group_name"]
  network_security_group_name                = each.value["network_security_group_name"]
  source_port_range                          = try(each.value.source_port_range, null)
  source_port_ranges                         = try(each.value.source_port_ranges, null)
  destination_port_range                     = try(each.value.destination_port_range, null)
  destination_port_ranges                    = try(each.value.destination_port_ranges, null)
  source_address_prefix                      = try(each.value.source_address_prefix, null)
  source_address_prefixes                    = try(each.value.source_address_prefixes, null)
  destination_address_prefix                 = try(each.value.destination_address_prefix, null)
  destination_address_prefixes               = try(each.value.destination_address_prefixes, null)
  source_application_security_group_ids      = try(each.value.source_application_security_group_ids, null)
  destination_application_security_group_ids = try(each.value.destination_application_security_group_ids, null)

  depends_on = [module.nsg]
}