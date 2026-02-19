################################################################################
# Azure Site Recovery Network Mapping
################################################################################

resource "azurerm_site_recovery_network_mapping" "this" {
  count = var.create ? 1 : 0

  name                        = var.name
  resource_group_name         = var.resource_group_name
  recovery_vault_name         = var.recovery_vault_name
  source_recovery_fabric_name = var.source_recovery_fabric_name
  target_recovery_fabric_name = var.target_recovery_fabric_name
  source_network_id           = var.source_network_id
  target_network_id           = var.target_network_id
}
