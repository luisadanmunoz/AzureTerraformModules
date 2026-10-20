#############################################################################
# MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE PRIVATE ENDPOINTS
#############################################################################
module "machine_learning_workspace_network_outbound_rule_private_endpoint" {
  source = "./modules/machine_learning_workspace_network_outbound_rule_private_endpoint"

  for_each = var.machine_learning_workspace_network_outbound_rule_private_endpoints

  machine_learning_workspace_network_outbound_rule_private_endpoint_name = each.value["machine_learning_workspace_network_outbound_rule_private_endpoint_name"]
  workspace_id = try(
    element([for _, machine_learning_workspace in module.machine_learning_workspace : machine_learning_workspace.id if machine_learning_workspace.name == each.value["machine_learning_workspace_name"]], 0),
    each.value["workspace_id"]
  )
  service_resource_id = each.value["service_resource_id"]
  sub_resource_target = each.value["sub_resource_target"]
  spark_enabled       = try(each.value["spark_enabled"], null)
  timeouts            = try(each.value["timeouts"], null)
}
