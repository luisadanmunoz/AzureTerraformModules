#############################################################################
# POLICY EXEMPTIONS
#############################################################################
module "policy_exemption" {
  source = "./modules/policy_exemption"

  for_each = var.policy_exemptions

  scope_type = each.value["scope_type"]
  scope_id = try(
    element([for _, resource_group in module.rg : resource_group.id if resource_group.name == each.value["resource_group_name"]], 0),
    element([for _, management_group in module.management_group : management_group.id if management_group.name == each.value["management_group_name"]], 0),
    each.value["scope_id"]
  )
  policy_exemption_name = each.value["policy_exemption_name"]
  policy_assignment_id = try(
    element([for _, policy_assignment in module.policy_assignment : policy_assignment.id if policy_assignment.name == each.value["policy_assignment_name"]], 0),
    each.value["policy_assignment_id"]
  )
  exemption_category              = try(each.value["exemption_category"], "Waiver")
  display_name                    = try(each.value["display_name"], null)
  description                     = try(each.value["description"], null)
  expires_on                      = try(each.value["expires_on"], null)
  metadata                        = try(each.value["metadata"], null)
  policy_definition_reference_ids = try(each.value["policy_definition_reference_ids"], [])
}
