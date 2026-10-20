################################################################################
# Integration Account Outputs
################################################################################

output "id" {
  description = "The ID of the Integration Account."
  value       = var.create ? azurerm_logic_app_integration_account.this[0].id : null
}

output "name" {
  description = "The name of the Integration Account."
  value       = var.create ? azurerm_logic_app_integration_account.this[0].name : null
}

output "sku_name" {
  description = "The SKU of the Integration Account."
  value       = var.create ? azurerm_logic_app_integration_account.this[0].sku_name : null
}
