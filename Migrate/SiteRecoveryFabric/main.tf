################################################################################
# Azure Site Recovery Fabric
################################################################################

resource "azurerm_site_recovery_fabric" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name
  location            = var.location
}
