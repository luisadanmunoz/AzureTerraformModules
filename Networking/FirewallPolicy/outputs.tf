################################################################################
# Firewall Policy Outputs
################################################################################

output "id" {
  description = "The ID of the Firewall Policy."
  value       = var.create ? azurerm_firewall_policy.this[0].id : null
}

output "name" {
  description = "The name of the Firewall Policy."
  value       = var.create ? azurerm_firewall_policy.this[0].name : null
}

output "child_policies" {
  description = "List of child policy IDs."
  value       = var.create ? azurerm_firewall_policy.this[0].child_policies : null
}

output "firewalls" {
  description = "List of firewall IDs using this policy."
  value       = var.create ? azurerm_firewall_policy.this[0].firewalls : null
}

output "rule_collection_groups" {
  description = "List of rule collection group IDs."
  value       = var.create ? azurerm_firewall_policy.this[0].rule_collection_groups : null
}
