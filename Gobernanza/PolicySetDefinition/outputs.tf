################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Policy Set Definition."
  value = var.create ? (
    local.is_management_group_scope
    ? azurerm_management_group_policy_set_definition.this[0].id
    : azurerm_policy_set_definition.subscription[0].id
  ) : null
}

output "name" {
  description = "The name of the Policy Set Definition."
  value = var.create ? (
    local.is_management_group_scope
    ? azurerm_management_group_policy_set_definition.this[0].name
    : azurerm_policy_set_definition.subscription[0].name
  ) : null
}
