################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Budget."
  value = var.create ? coalesce(
    try(azurerm_consumption_budget_subscription.this[0].id, null),
    try(azurerm_consumption_budget_resource_group.this[0].id, null),
    try(azurerm_consumption_budget_management_group.this[0].id, null)
  ) : null
}

output "name" {
  description = "The name of the Budget."
  value       = var.create ? var.name : null
}
