#############################################################################
# OUTPUT BUDGET
#############################################################################
output "id" {
  value = coalesce(
    try(azurerm_consumption_budget_management_group.budget_management_group[0].id, null),
    try(azurerm_consumption_budget_subscription.budget_subscription[0].id, null),
    try(azurerm_consumption_budget_resource_group.budget_resource_group[0].id, null)
  )
}
