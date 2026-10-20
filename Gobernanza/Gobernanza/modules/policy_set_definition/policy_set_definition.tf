#############################################################################
# POLICY SET DEFINITION
#############################################################################
resource "azurerm_policy_set_definition" "policy_set_definition" {
  name                = var.policy_set_definition_name
  display_name        = var.display_name
  description         = var.description
  policy_type         = var.policy_type
  management_group_id = var.management_group_id
  metadata            = jsonencode(var.metadata)
  parameters          = var.parameters == null ? null : jsonencode(var.parameters)

  dynamic "policy_definition_reference" {
    for_each = var.policy_definitions

    content {
      policy_definition_id = policy_definition_reference.value.policy_definition_id
      reference_id         = try(policy_definition_reference.value.reference_id, null)
      parameter_values     = try(policy_definition_reference.value.parameter_values, null) == null ? null : jsonencode(policy_definition_reference.value.parameter_values)
    }
  }
}
