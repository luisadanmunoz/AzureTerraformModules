#############################################################################
# POLICY REMEDIATIONS
#############################################################################
module "policy_remediation" {
  source = "./modules/policy_remediation"

  for_each = var.policy_remediations

  remediation_name = each.value["remediation_name"]
  scope_type       = each.value["scope_type"]
  scope_id = try(
    element([for _, resource_group in module.rg : resource_group.id if resource_group.name == each.value["resource_group_name"]], 0),
    element([for _, management_group in module.management_group : management_group.id if management_group.name == each.value["management_group_name"]], 0),
    each.value["scope_id"],
    each.value["subscription_id"]
  )
  policy_assignment_id = try(
    element([for _, policy_assignment in module.policy_assignment : policy_assignment.id if policy_assignment.name == each.value["policy_assignment_name"]], 0),
    each.value["policy_assignment_id"]
  )
  policy_definition_reference_id = try(each.value["policy_definition_reference_id"], null)
}
