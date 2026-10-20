################################################################################
# Outputs
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
  description = "A list of references to child Firewall Policies of this Firewall Policy."
  value       = var.create ? azurerm_firewall_policy.this[0].child_policies : null
}

output "firewalls" {
  description = "A list of references to Azure Firewalls that this Firewall Policy is associated with."
  value       = var.create ? azurerm_firewall_policy.this[0].firewalls : null
}

output "rule_collection_groups" {
  description = "A list of references to Firewall Policy Rule Collection Groups that belong to this Firewall Policy."
  value       = var.create ? azurerm_firewall_policy.this[0].rule_collection_groups : null
}

output "resource_group_name" {
  description = "The resource group name of the Firewall Policy."
  value       = var.create ? azurerm_firewall_policy.this[0].resource_group_name : null
}

output "location" {
  description = "The location of the Firewall Policy."
  value       = var.create ? azurerm_firewall_policy.this[0].location : null
}
