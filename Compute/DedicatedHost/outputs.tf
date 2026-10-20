################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Dedicated Host."
  value       = var.create ? azurerm_dedicated_host.this[0].id : null
}

output "name" {
  description = "The name of the Dedicated Host."
  value       = var.create ? azurerm_dedicated_host.this[0].name : null
}

output "sku_name" {
  description = "The SKU of the Dedicated Host."
  value       = var.sku_name
}

output "dedicated_host_group_id" {
  description = "The ID of the parent Host Group."
  value       = var.dedicated_host_group_id
}
