################################################################################
# Network Security Group Outputs
################################################################################

output "id" {
  description = "The ID of the Network Security Group."
  value       = var.create ? azurerm_network_security_group.this[0].id : null
}

output "name" {
  description = "The name of the Network Security Group."
  value       = var.create ? azurerm_network_security_group.this[0].name : null
}

output "resource_group_name" {
  description = "The name of the Resource Group containing the NSG."
  value       = var.create ? azurerm_network_security_group.this[0].resource_group_name : null
}

output "location" {
  description = "The Azure region where the NSG is deployed."
  value       = var.create ? azurerm_network_security_group.this[0].location : null
}

################################################################################
# Security Rules Outputs
################################################################################

output "security_rule_ids" {
  description = "Map of security rule names to their IDs."
  value       = { for k, v in azurerm_network_security_rule.this : k => v.id }
}

output "security_rules" {
  description = "Map of security rule names to their full configuration."
  value = { for k, v in azurerm_network_security_rule.this : k => {
    id        = v.id
    name      = v.name
    priority  = v.priority
    direction = v.direction
    access    = v.access
    protocol  = v.protocol
  } }
}

################################################################################
# Diagnostic Settings Outputs
################################################################################

output "diagnostic_settings_id" {
  description = "The ID of the diagnostic settings (if created)."
  value       = local.create_diagnostic_settings ? azurerm_monitor_diagnostic_setting.this[0].id : null
}
