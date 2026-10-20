#############################################################################
# MANAGEMENT GROUP POLICY ASSIGNMENT
#############################################################################

module "policy_assignment" {
  source = "./module/policy_assignment"

  for_each = var.policy_assignment

  name                 = each.value["name"]
  policy_definition_id = each.value["policy_definition_id"]
  management_group_id  = each.value["management_group_id"]
  location             = each.value["location"]
  display_name         = each.value["display_name"]
  description          = each.value["description"]
  parameters           = each.value["parameters"]
  policy_type          = each.value["policy_type"]
  identity             = each.value["identity"]
  identity_ids         = toset([for k, v in module.assigned_identity : v.id if v.name == each.value["identity_ids"]])

  depends_on = [module.assigned_identity]
}