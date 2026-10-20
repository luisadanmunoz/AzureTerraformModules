#############################################################################
# POLICY DEFINITION
#############################################################################
resource "azurerm_policy_definition" "policy_definition" {
  name                = var.policy_definition_name
  display_name        = var.display_name
  description         = var.description
  policy_type         = var.policy_type
  mode                = var.mode
  management_group_id = var.management_group_id
  metadata            = jsonencode(var.metadata)
  parameters          = var.parameters == null ? null : jsonencode(var.parameters)
  policy_rule         = jsonencode(var.policy_rule)
}
