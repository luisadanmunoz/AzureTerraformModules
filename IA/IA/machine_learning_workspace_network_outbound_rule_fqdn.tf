#############################################################################
# MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE FQDNS
#############################################################################
module "machine_learning_workspace_network_outbound_rule_fqdn" {
  source = "./modules/machine_learning_workspace_network_outbound_rule_fqdn"

  for_each = var.machine_learning_workspace_network_outbound_rule_fqdns

  machine_learning_workspace_network_outbound_rule_fqdn_name = each.value["machine_learning_workspace_network_outbound_rule_fqdn_name"]
  workspace_id = try(
    element([for _, machine_learning_workspace in module.machine_learning_workspace : machine_learning_workspace.id if machine_learning_workspace.name == each.value["machine_learning_workspace_name"]], 0),
    each.value["workspace_id"]
  )
  destination_fqdn = each.value["destination_fqdn"]
  timeouts         = try(each.value["timeouts"], null)
}
