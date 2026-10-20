################################################################################
# Azure Database Migration Project
################################################################################

resource "azurerm_database_migration_project" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_name        = var.service_name
  source_platform     = var.source_platform
  target_platform     = var.target_platform

  tags = local.tags
}
