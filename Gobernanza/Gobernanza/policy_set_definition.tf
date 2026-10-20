#############################################################################
# POLICY SET DEFINITIONS
#############################################################################
module "policy_set_definition" {
  source = "./modules/policy_set_definition"

  for_each = var.policy_set_definitions

  policy_set_definition_name = each.value["policy_set_definition_name"]
  display_name               = each.value["display_name"]
  description                = try(each.value["description"], null)
  policy_type                = try(each.value["policy_type"], "Custom")
  management_group_id = try(
    element([for _, management_group in module.management_group : management_group.id if management_group.name == each.value["management_group_name"]], 0),
    each.value["management_group_id"],
    null
  )
  metadata   = try(each.value["metadata"], {})
  parameters = try(each.value["parameters"], null)
  policy_definitions = [
    for policy_definition in each.value["policy_definitions"] : merge(
      policy_definition,
      {
        policy_definition_id = try(
          element([for _, module_policy_definition in module.policy_definition : module_policy_definition.id if module_policy_definition.name == policy_definition["policy_definition_name"]], 0),
          policy_definition["policy_definition_id"]
        )
      }
    )
  ]
}
