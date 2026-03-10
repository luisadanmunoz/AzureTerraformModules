################################################################################
# Virtual Network Manager Outputs
################################################################################

output "id" {
  description = "The ID of the Virtual Network Manager."
  value       = var.create ? azurerm_network_manager.this[0].id : null
}

output "name" {
  description = "The name of the Virtual Network Manager."
  value       = var.create ? azurerm_network_manager.this[0].name : null
}

output "cross_tenant_scopes" {
  description = "The cross-tenant scopes of the Virtual Network Manager."
  value       = var.create ? azurerm_network_manager.this[0].cross_tenant_scopes : null
}

################################################################################
# Network Group Outputs
################################################################################

output "network_group_ids" {
  description = "A map of Network Group names to their IDs."
  value = {
    for idx, ng in azurerm_network_manager_network_group.this :
    var.network_groups[idx].name => ng.id
  }
}

################################################################################
# Connectivity Configuration Outputs
################################################################################

output "connectivity_configuration_ids" {
  description = "A map of Connectivity Configuration names to their IDs."
  value = {
    for idx, cc in azurerm_network_manager_connectivity_configuration.this :
    var.connectivity_configurations[idx].name => cc.id
  }
}

################################################################################
# Security Admin Configuration Outputs
################################################################################

output "security_admin_configuration_ids" {
  description = "A map of Security Admin Configuration names to their IDs."
  value = {
    for idx, sac in azurerm_network_manager_security_admin_configuration.this :
    var.security_admin_configurations[idx].name => sac.id
  }
}

output "admin_rule_collection_ids" {
  description = "A map of Admin Rule Collection names to their IDs."
  value = {
    for idx, rc in azurerm_network_manager_admin_rule_collection.this :
    local.security_rule_collections[idx].name => rc.id
  }
}
