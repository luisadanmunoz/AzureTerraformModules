################################################################################
# Logic App Outputs
################################################################################

output "id" {
  description = "The ID of the Logic App Workflow."
  value       = var.create ? azurerm_logic_app_workflow.this[0].id : null
}

output "name" {
  description = "The name of the Logic App Workflow."
  value       = var.create ? azurerm_logic_app_workflow.this[0].name : null
}

output "access_endpoint" {
  description = "The Access Endpoint for the Logic App Workflow."
  value       = var.create ? azurerm_logic_app_workflow.this[0].access_endpoint : null
}

output "connector_endpoint_ip_addresses" {
  description = "The list of connector endpoint IP addresses."
  value       = var.create ? azurerm_logic_app_workflow.this[0].connector_endpoint_ip_addresses : null
}

output "connector_outbound_ip_addresses" {
  description = "The list of outbound connector IP addresses."
  value       = var.create ? azurerm_logic_app_workflow.this[0].connector_outbound_ip_addresses : null
}

output "workflow_endpoint_ip_addresses" {
  description = "The list of workflow endpoint IP addresses."
  value       = var.create ? azurerm_logic_app_workflow.this[0].workflow_endpoint_ip_addresses : null
}

output "workflow_outbound_ip_addresses" {
  description = "The list of workflow outbound IP addresses."
  value       = var.create ? azurerm_logic_app_workflow.this[0].workflow_outbound_ip_addresses : null
}

output "identity" {
  description = "The identity block of the Logic App."
  value       = var.create && var.identity != null ? azurerm_logic_app_workflow.this[0].identity : null
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Identity."
  value       = var.create && var.identity != null ? try(azurerm_logic_app_workflow.this[0].identity[0].principal_id, null) : null
}

output "tenant_id" {
  description = "The Tenant ID of the System Assigned Identity."
  value       = var.create && var.identity != null ? try(azurerm_logic_app_workflow.this[0].identity[0].tenant_id, null) : null
}
