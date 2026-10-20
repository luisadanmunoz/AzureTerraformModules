################################################################################
# Azure Machine Learning Workspace
################################################################################

resource "azurerm_machine_learning_workspace" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  application_insights_id = var.application_insights_id
  key_vault_id            = var.key_vault_id
  storage_account_id      = var.storage_account_id
  container_registry_id   = var.container_registry_id

  public_network_access_enabled = var.public_network_access_enabled
  image_build_compute_name      = var.image_build_compute_name
  description                   = var.description
  friendly_name                 = var.friendly_name
  high_business_impact          = var.high_business_impact
  sku_name                      = var.sku_name
  v1_legacy_mode_enabled        = var.v1_legacy_mode_enabled

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  tags = local.tags
}
