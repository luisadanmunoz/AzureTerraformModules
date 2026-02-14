################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Management Group."
  value       = var.create ? azurerm_management_group.this[0].id : null
}

output "name" {
  description = "The name of the Management Group."
  value       = var.create ? azurerm_management_group.this[0].name : null
}

output "tenant_scoped_id" {
  description = "The tenant-scoped ID of the Management Group."
  value       = var.create ? azurerm_management_group.this[0].tenant_scoped_id : null
}
