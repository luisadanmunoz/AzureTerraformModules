################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Firewall Policy Rule Collection Group."
  value       = var.create ? azurerm_firewall_policy_rule_collection_group.this[0].id : null
}

output "name" {
  description = "The name of the Firewall Policy Rule Collection Group."
  value       = var.create ? azurerm_firewall_policy_rule_collection_group.this[0].name : null
}
