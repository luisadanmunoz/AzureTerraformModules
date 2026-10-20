#############################################################################
# MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE SERVICE TAGS
#############################################################################
module "machine_learning_workspace_network_outbound_rule_service_tag" {
  source = "./modules/machine_learning_workspace_network_outbound_rule_service_tag"

  for_each = var.machine_learning_workspace_network_outbound_rule_service_tags

  machine_learning_workspace_network_outbound_rule_service_tag_name = each.value["machine_learning_workspace_network_outbound_rule_service_tag_name"]
  workspace_id = try(
    element([for _, machine_learning_workspace in module.machine_learning_workspace : machine_learning_workspace.id if machine_learning_workspace.name == each.value["machine_learning_workspace_name"]], 0),
    each.value["workspace_id"]
  )
  service_tag = each.value["service_tag"]
  protocol    = each.value["protocol"]
  port_ranges = each.value["port_ranges"]
  timeouts    = try(each.value["timeouts"], null)
}
