#############################################################################
# OUTPUT POLICY EXEMPTION
#############################################################################
output "id" {
  value = coalesce(
    try(azurerm_management_group_policy_exemption.policy_exemption_management_group[0].id, null),
    try(azurerm_subscription_policy_exemption.policy_exemption_subscription[0].id, null),
    try(azurerm_resource_group_policy_exemption.policy_exemption_resource_group[0].id, null),
    try(azurerm_resource_policy_exemption.policy_exemption_resource[0].id, null)
  )
}
