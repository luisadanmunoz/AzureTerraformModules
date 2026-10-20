################################################################################
# Storage Management Policy Outputs
################################################################################

output "id" {
  description = "The ID of the Storage Management Policy."
  value       = var.create ? azurerm_storage_management_policy.this[0].id : null
}
