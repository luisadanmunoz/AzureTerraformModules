################################################################################
# Integration Account
# DEPENDENCY: Resource Group must exist.
################################################################################

resource "azurerm_logic_app_integration_account" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name

  integration_service_environment_id = var.integration_service_environment_id

  tags = local.tags
}
