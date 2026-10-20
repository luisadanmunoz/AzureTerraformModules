################################################################################
# Azure Policy Definition - Subscription Scope
################################################################################

resource "azurerm_policy_definition" "subscription" {
  count = var.create && !local.is_management_group_scope ? 1 : 0

  name         = var.name
  policy_type  = var.policy_type
  mode         = var.mode
  display_name = var.display_name
  description  = var.description

  policy_rule = local.policy_rule
  metadata    = var.metadata
  parameters  = var.parameters
}

################################################################################
# Azure Policy Definition - Management Group Scope
################################################################################

resource "azurerm_management_group_policy_definition" "this" {
  count = var.create && local.is_management_group_scope ? 1 : 0

  name                = var.name
  policy_type         = var.policy_type
  mode                = var.mode
  display_name        = var.display_name
  description         = var.description
  management_group_id = var.management_group_id

  policy_rule = local.policy_rule
  metadata    = var.metadata
  parameters  = var.parameters
}
