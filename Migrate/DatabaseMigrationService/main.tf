################################################################################
# Azure Database Migration Service
################################################################################

resource "azurerm_database_migration_service" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id
  sku_name            = var.sku_name

  tags = local.tags
}
