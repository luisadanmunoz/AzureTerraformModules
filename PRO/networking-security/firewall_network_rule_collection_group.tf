#############################################################################
# AZURE FIREWALL NETWORK RULE COLLECTION GROUP
#############################################################################
module "firewall_network_rule_collection_group" {
  source = "./modules/firewall_network_rule_collection_group"

  for_each = var.firewall_network_rule_collection_group

  name               = each.value["name"]
  firewall_policy_id = element([for k, v in module.firewall : v.policy_id if v.policy_name == each.value["name_firewall_policy"]], 0)
  priority           = each.value["priority"]

  name_network_rule_collection     = each.value["name_network_rule_collection"]
  priority_network_rule_collection = each.value["priority_network_rule_collection"]
  action                           = each.value["action"]

  name_rule             = each.value["name_rule"]
  protocols             = each.value["protocols"]
  source_addresses      = each.value["source_addresses"]
  destination_addresses = each.value["destination_addresses"]
  destination_ports     = each.value["destination_ports"]

}
