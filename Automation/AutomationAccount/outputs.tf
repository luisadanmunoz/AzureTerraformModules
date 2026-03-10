################################################################################
# Automation Account Outputs
################################################################################

output "id" {
  description = "The ID of the Automation Account."
  value       = var.create ? azurerm_automation_account.this[0].id : null
}

output "name" {
  description = "The name of the Automation Account."
  value       = var.create ? azurerm_automation_account.this[0].name : null
}

output "dsc_server_endpoint" {
  description = "The DSC Server Endpoint associated with this Automation Account."
  value       = var.create ? azurerm_automation_account.this[0].dsc_server_endpoint : null
}

output "dsc_primary_access_key" {
  description = "The Primary Access Key for the DSC Endpoint."
  value       = var.create ? azurerm_automation_account.this[0].dsc_primary_access_key : null
  sensitive   = true
}

output "dsc_secondary_access_key" {
  description = "The Secondary Access Key for the DSC Endpoint."
  value       = var.create ? azurerm_automation_account.this[0].dsc_secondary_access_key : null
  sensitive   = true
}

output "hybrid_service_url" {
  description = "The URL of the Hybrid Worker Service."
  value       = var.create ? azurerm_automation_account.this[0].hybrid_service_url : null
}

output "identity" {
  description = "The identity block of the Automation Account."
  value       = var.create && var.identity != null ? azurerm_automation_account.this[0].identity : null
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Identity (if enabled)."
  value       = var.create && var.identity != null ? try(azurerm_automation_account.this[0].identity[0].principal_id, null) : null
}

output "tenant_id" {
  description = "The Tenant ID of the System Assigned Identity (if enabled)."
  value       = var.create && var.identity != null ? try(azurerm_automation_account.this[0].identity[0].tenant_id, null) : null
}

output "private_endpoint_ids" {
  description = "Map of Private Endpoint names to their IDs."
  value = {
    for name, pe in azurerm_private_endpoint.this :
    name => pe.id
  }
}

output "private_endpoint_ips" {
  description = "Map of Private Endpoint names to their private IP addresses."
  value = {
    for name, pe in azurerm_private_endpoint.this :
    name => pe.private_service_connection[0].private_ip_address
  }
}
