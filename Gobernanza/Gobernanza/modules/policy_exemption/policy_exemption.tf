#############################################################################
# POLICY EXEMPTION
#############################################################################
resource "azurerm_management_group_policy_exemption" "policy_exemption_management_group" {
  count = var.scope_type == "management_group" ? 1 : 0

  name                            = var.policy_exemption_name
  management_group_id             = var.scope_id
  policy_assignment_id            = var.policy_assignment_id
  exemption_category              = var.exemption_category
  display_name                    = var.display_name
  description                     = var.description
  expires_on                      = var.expires_on
  metadata                        = var.metadata == null ? null : jsonencode(var.metadata)
  policy_definition_reference_ids = var.policy_definition_reference_ids
}

resource "azurerm_subscription_policy_exemption" "policy_exemption_subscription" {
  count = var.scope_type == "subscription" ? 1 : 0

  name                            = var.policy_exemption_name
  subscription_id                 = var.scope_id
  policy_assignment_id            = var.policy_assignment_id
  exemption_category              = var.exemption_category
  display_name                    = var.display_name
  description                     = var.description
  expires_on                      = var.expires_on
  metadata                        = var.metadata == null ? null : jsonencode(var.metadata)
  policy_definition_reference_ids = var.policy_definition_reference_ids
}

resource "azurerm_resource_group_policy_exemption" "policy_exemption_resource_group" {
  count = var.scope_type == "resource_group" ? 1 : 0

  name                            = var.policy_exemption_name
  resource_group_id               = var.scope_id
  policy_assignment_id            = var.policy_assignment_id
  exemption_category              = var.exemption_category
  display_name                    = var.display_name
  description                     = var.description
  expires_on                      = var.expires_on
  metadata                        = var.metadata == null ? null : jsonencode(var.metadata)
  policy_definition_reference_ids = var.policy_definition_reference_ids
}

resource "azurerm_resource_policy_exemption" "policy_exemption_resource" {
  count = var.scope_type == "resource" ? 1 : 0

  name                            = var.policy_exemption_name
  resource_id                     = var.scope_id
  policy_assignment_id            = var.policy_assignment_id
  exemption_category              = var.exemption_category
  display_name                    = var.display_name
  description                     = var.description
  expires_on                      = var.expires_on
  metadata                        = var.metadata == null ? null : jsonencode(var.metadata)
  policy_definition_reference_ids = var.policy_definition_reference_ids
}
