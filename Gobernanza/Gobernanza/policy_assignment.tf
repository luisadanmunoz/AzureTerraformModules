#############################################################################
# POLICY ASSIGNMENTS
#############################################################################
module "policy_assignment" {
  source = "./modules/policy_assignment"

  for_each = var.policy_assignments

  scope_type = each.value["scope_type"]
  scope_id = try(
    element([for _, resource_group in module.rg : resource_group.id if resource_group.name == each.value["resource_group_name"]], 0),
    element([for _, management_group in module.management_group : management_group.id if management_group.name == each.value["management_group_name"]], 0),
    each.value["scope_id"]
  )
  policy_assignment_name = each.value["policy_assignment_name"]
  display_name           = try(each.value["display_name"], null)
  description            = try(each.value["description"], null)
  policy_definition_id = try(
    element([for _, policy_definition in module.policy_definition : policy_definition.id if policy_definition.name == each.value["policy_definition_name"]], 0),
    element([for _, policy_set_definition in module.policy_set_definition : policy_set_definition.id if policy_set_definition.name == each.value["policy_set_definition_name"]], 0),
    each.value["policy_definition_id"]
  )
  parameters    = try(each.value["parameters"], null)
  location      = try(each.value["location"], null)
  identity_type = try(each.value["identity_type"], null)
  identity_ids  = try(each.value["identity_ids"], [])
  not_scopes    = try(each.value["not_scopes"], [])
  enforce       = try(each.value["enforce"], true)
  metadata      = try(each.value["metadata"], null)
}
