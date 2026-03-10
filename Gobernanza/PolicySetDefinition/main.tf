################################################################################
# Azure Policy Set Definition (Initiative) - Subscription Scope
################################################################################

resource "azurerm_policy_set_definition" "subscription" {
  count = var.create && !local.is_management_group_scope ? 1 : 0

  name         = var.name
  policy_type  = var.policy_type
  display_name = var.display_name
  description  = var.description
  metadata     = var.metadata
  parameters   = var.parameters

  dynamic "policy_definition_reference" {
    for_each = var.policy_definitions
    content {
      policy_definition_id = policy_definition_reference.value.policy_definition_id
      reference_id         = policy_definition_reference.value.reference_id
      parameter_values     = policy_definition_reference.value.parameter_values
      policy_group_names   = policy_definition_reference.value.policy_group_names
    }
  }

  dynamic "policy_definition_group" {
    for_each = var.policy_definition_groups
    content {
      name                            = policy_definition_group.value.name
      display_name                    = policy_definition_group.value.display_name
      description                     = policy_definition_group.value.description
      category                        = policy_definition_group.value.category
      additional_metadata_resource_id = policy_definition_group.value.additional_metadata_resource_id
    }
  }
}

################################################################################
# Azure Policy Set Definition (Initiative) - Management Group Scope
################################################################################

resource "azurerm_management_group_policy_set_definition" "this" {
  count = var.create && local.is_management_group_scope ? 1 : 0

  name                = var.name
  policy_type         = var.policy_type
  display_name        = var.display_name
  description         = var.description
  management_group_id = var.management_group_id
  metadata            = var.metadata
  parameters          = var.parameters

  dynamic "policy_definition_reference" {
    for_each = var.policy_definitions
    content {
      policy_definition_id = policy_definition_reference.value.policy_definition_id
      reference_id         = policy_definition_reference.value.reference_id
      parameter_values     = policy_definition_reference.value.parameter_values
      policy_group_names   = policy_definition_reference.value.policy_group_names
    }
  }

  dynamic "policy_definition_group" {
    for_each = var.policy_definition_groups
    content {
      name                            = policy_definition_group.value.name
      display_name                    = policy_definition_group.value.display_name
      description                     = policy_definition_group.value.description
      category                        = policy_definition_group.value.category
      additional_metadata_resource_id = policy_definition_group.value.additional_metadata_resource_id
    }
  }
}
