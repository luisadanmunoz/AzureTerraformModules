################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Management Lock."
  value = var.create ? coalesce(
    try(azurerm_management_lock.resource_group[0].id, null),
    try(azurerm_management_lock.resource[0].id, null),
    try(azurerm_management_lock.subscription[0].id, null)
  ) : null
}

output "name" {
  description = "The name of the Management Lock."
  value       = var.create ? var.name : null
}
