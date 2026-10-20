#############################################################################
# POLICY DEFINITION 
#############################################################################

module "policy_definition" {
  source = "../module/policy_definition"

  for_each = var.policy_definition

  name                = each.value["name"]
  policy_type         = each.value["policy_type"]
  mode                = each.value["mode"]
  display_name        = each.value["display_name"]
  management_group_id = each.value["management_group_id"]
  policy_rule         = each.value["policy_rule"]
  description         = each.value["description"]

  #############################################################################
  # MANAGEMENT GROUP POLICY ASSIGNMENT
  #############################################################################

  location     = each.value["location"]
  identity     = each.value["identity"]
  identity_ids = toset([for k, v in module.assigned_identity : v.id if v.name == each.value["identity_ids"]])

  depends_on = [module.management_groups]

}