################################################################################
# OpenAI Account Outputs
################################################################################

output "id" {
  description = "The ID of the OpenAI account."
  value       = var.create ? azurerm_cognitive_account.this[0].id : null
}

output "name" {
  description = "The name of the OpenAI account."
  value       = var.create ? azurerm_cognitive_account.this[0].name : null
}

output "endpoint" {
  description = "The endpoint of the OpenAI account."
  value       = var.create ? azurerm_cognitive_account.this[0].endpoint : null
}

output "primary_access_key" {
  description = "The primary access key."
  value       = var.create ? azurerm_cognitive_account.this[0].primary_access_key : null
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key."
  value       = var.create ? azurerm_cognitive_account.this[0].secondary_access_key : null
  sensitive   = true
}

output "identity" {
  description = "The identity block."
  value       = var.create ? azurerm_cognitive_account.this[0].identity : null
}

output "principal_id" {
  description = "The principal ID of the system-assigned identity."
  value       = var.create ? try(azurerm_cognitive_account.this[0].identity[0].principal_id, null) : null
}
