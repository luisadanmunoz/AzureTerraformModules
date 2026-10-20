#############################################################################
# POLICY REMEDIATION
#############################################################################
resource "azurerm_management_group_policy_remediation" "policy_remediation_management_group" {
  count = var.scope_type == "management_group" ? 1 : 0

  name                           = var.remediation_name
  management_group_id            = var.scope_id
  policy_assignment_id           = var.policy_assignment_id
  policy_definition_reference_id = var.policy_definition_reference_id
}

resource "azurerm_subscription_policy_remediation" "policy_remediation_subscription" {
  count = var.scope_type == "subscription" ? 1 : 0

  name                           = var.remediation_name
  subscription_id                = var.scope_id
  policy_assignment_id           = var.policy_assignment_id
  policy_definition_reference_id = var.policy_definition_reference_id
}

resource "azurerm_resource_group_policy_remediation" "policy_remediation_resource_group" {
  count = var.scope_type == "resource_group" ? 1 : 0

  name                           = var.remediation_name
  resource_group_id              = var.scope_id
  policy_assignment_id           = var.policy_assignment_id
  policy_definition_reference_id = var.policy_definition_reference_id
}
