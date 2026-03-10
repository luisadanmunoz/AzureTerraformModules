################################################################################
# OpenAI Deployment Outputs
################################################################################

output "id" {
  description = "The ID of the deployment."
  value       = var.create ? azurerm_cognitive_deployment.this[0].id : null
}

output "name" {
  description = "The name of the deployment."
  value       = var.create ? azurerm_cognitive_deployment.this[0].name : null
}

output "model_name" {
  description = "The model name."
  value       = var.create ? var.model_name : null
}

output "model_version" {
  description = "The model version."
  value       = var.create ? var.model_version : null
}
