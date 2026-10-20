################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Policy Definition."
  value = var.create ? (
    local.is_management_group_scope
    ? azurerm_management_group_policy_definition.this[0].id
    : azurerm_policy_definition.subscription[0].id
  ) : null
}

output "name" {
  description = "The name of the Policy Definition."
  value = var.create ? (
    local.is_management_group_scope
    ? azurerm_management_group_policy_definition.this[0].name
    : azurerm_policy_definition.subscription[0].name
  ) : null
}

output "role_definition_ids" {
  description = "The role definition IDs required for remediation (for DeployIfNotExists/Modify effects)."
  value = var.create ? (
    local.is_management_group_scope
    ? azurerm_management_group_policy_definition.this[0].role_definition_ids
    : azurerm_policy_definition.subscription[0].role_definition_ids
  ) : null
}
