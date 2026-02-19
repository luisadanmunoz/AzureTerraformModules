################################################################################
# Site Recovery Replication Policy Outputs
################################################################################

output "id" {
  description = "The ID of the Replication Policy."
  value       = var.create ? azurerm_site_recovery_replication_policy.this[0].id : null
}

output "name" {
  description = "The name of the Replication Policy."
  value       = var.create ? azurerm_site_recovery_replication_policy.this[0].name : null
}
