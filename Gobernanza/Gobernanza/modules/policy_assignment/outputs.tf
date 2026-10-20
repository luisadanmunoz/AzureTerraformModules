#############################################################################
# OUTPUT POLICY ASSIGNMENT
#############################################################################
output "id" {
  value = coalesce(
    try(azurerm_management_group_policy_assignment.policy_assignment_management_group[0].id, null),
    try(azurerm_subscription_policy_assignment.policy_assignment_subscription[0].id, null),
    try(azurerm_resource_group_policy_assignment.policy_assignment_resource_group[0].id, null),
    try(azurerm_resource_policy_assignment.policy_assignment_resource[0].id, null)
  )
}

output "name" {
  value = var.policy_assignment_name
}
