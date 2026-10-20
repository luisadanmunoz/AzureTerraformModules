#############################################################################
# POLICY DEFINITIONS
#############################################################################
module "policy_definition" {
  source = "./modules/policy_definition"

  for_each = var.policy_definitions

  policy_definition_name = each.value["policy_definition_name"]
  display_name           = each.value["display_name"]
  description            = try(each.value["description"], null)
  policy_type            = try(each.value["policy_type"], "Custom")
  mode                   = try(each.value["mode"], "All")
  management_group_id = try(
    element([for _, management_group in module.management_group : management_group.id if management_group.name == each.value["management_group_name"]], 0),
    each.value["management_group_id"],
    null
  )
  metadata    = try(each.value["metadata"], {})
  parameters  = try(each.value["parameters"], null)
  policy_rule = each.value["policy_rule"]
}
