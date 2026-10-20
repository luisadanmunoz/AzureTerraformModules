#############################################################################
# OUTPUT POLICY REMEDIATION
#############################################################################
output "id" {
  value = coalesce(
    try(azurerm_management_group_policy_remediation.policy_remediation_management_group[0].id, null),
    try(azurerm_subscription_policy_remediation.policy_remediation_subscription[0].id, null),
    try(azurerm_resource_group_policy_remediation.policy_remediation_resource_group[0].id, null)
  )
}
