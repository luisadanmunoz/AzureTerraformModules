################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Policy Assignment."
  value = var.create ? coalesce(
    try(azurerm_subscription_policy_assignment.this[0].id, null),
    try(azurerm_resource_group_policy_assignment.this[0].id, null),
    try(azurerm_management_group_policy_assignment.this[0].id, null),
    try(azurerm_resource_policy_assignment.this[0].id, null)
  ) : null
}

output "name" {
  description = "The name of the Policy Assignment."
  value       = var.create ? var.name : null
}

output "identity" {
  description = "The identity of the Policy Assignment."
  value = var.create && var.identity != null ? coalesce(
    try(azurerm_subscription_policy_assignment.this[0].identity, null),
    try(azurerm_resource_group_policy_assignment.this[0].identity, null),
    try(azurerm_management_group_policy_assignment.this[0].identity, null),
    try(azurerm_resource_policy_assignment.this[0].identity, null)
  ) : null
}

output "principal_id" {
  description = "The Principal ID of the Policy Assignment's managed identity."
  value = var.create && var.identity != null ? coalesce(
    try(azurerm_subscription_policy_assignment.this[0].identity[0].principal_id, null),
    try(azurerm_resource_group_policy_assignment.this[0].identity[0].principal_id, null),
    try(azurerm_management_group_policy_assignment.this[0].identity[0].principal_id, null),
    try(azurerm_resource_policy_assignment.this[0].identity[0].principal_id, null)
  ) : null
}
