#############################################################################
# POLICY DEFINITION 
#############################################################################

module "Policy_SetDefinition" {
  source = "../module/Policy_SetDefinition"

  for_each = var.policy_definitions

  name                   = each.value.name
  initiative_name        = each.value.display_name
  policy_type            = each.value.policy_type
  policy_set_description = each.value.description
  management_group_id    = each.value.management_group_id
  parameters             = each.value.parameters
  policy_definitions     = each.value.policy_definitions
}