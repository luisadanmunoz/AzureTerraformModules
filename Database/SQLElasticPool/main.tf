################################################################################
# Azure SQL Elastic Pool
################################################################################

# DEPENDENCY: SQL Server must exist

resource "azurerm_mssql_elasticpool" "this" {
  count = var.create ? 1 : 0

  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = regex("[^/]+$", var.server_id)

  license_type                   = var.license_type
  max_size_gb                    = var.max_size_gb
  zone_redundant                 = var.zone_redundant
  maintenance_configuration_name = var.maintenance_configuration_name
  enclave_type                   = var.enclave_type

  # SKU configuration
  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    family   = var.sku.family
    capacity = var.sku.capacity
  }

  # Per-database settings
  per_database_settings {
    min_capacity = var.per_database_settings.min_capacity
    max_capacity = var.per_database_settings.max_capacity
  }

  tags = local.tags
}
