# -----------------------------------------------------------------------------
# AZURE COSMOS DB ACCOUNT
# This module creates an Azure Cosmos DB Account with configurable options
# for consistency, geo-replication, networking, backup, and more.
# -----------------------------------------------------------------------------

resource "azurerm_cosmosdb_account" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  # Account configuration
  offer_type = var.offer_type
  kind       = var.kind

  # MongoDB specific configuration
  mongo_server_version = var.kind == "MongoDB" ? var.mongo_server_version : null

  # High availability and replication
  enable_automatic_failover       = var.enable_automatic_failover
  enable_free_tier                = var.enable_free_tier
  enable_multiple_write_locations = var.enable_multiple_write_locations

  # Network configuration
  public_network_access_enabled     = var.public_network_access_enabled
  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled
  ip_range_filter                   = var.ip_range_filter

  # Analytical storage
  analytical_storage_enabled = var.analytical_storage_enabled

  # Customer-managed key encryption
  key_vault_key_id = var.key_vault_key_id

  # Consistency policy configuration
  dynamic "consistency_policy" {
    for_each = [var.consistency_policy]
    content {
      consistency_level       = consistency_policy.value.consistency_level
      max_interval_in_seconds = consistency_policy.value.consistency_level == "BoundedStaleness" ? consistency_policy.value.max_interval_in_seconds : null
      max_staleness_prefix    = consistency_policy.value.consistency_level == "BoundedStaleness" ? consistency_policy.value.max_staleness_prefix : null
    }
  }

  # Geo location configuration
  dynamic "geo_location" {
    for_each = local.geo_locations
    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.failover_priority
      zone_redundant    = geo_location.value.zone_redundant
    }
  }

  # Capabilities configuration
  dynamic "capabilities" {
    for_each = coalesce(var.capabilities, [])
    content {
      name = capabilities.value
    }
  }

  # Virtual network rules configuration
  dynamic "virtual_network_rule" {
    for_each = coalesce(var.virtual_network_rules, [])
    content {
      id                                   = virtual_network_rule.value.id
      ignore_missing_vnet_service_endpoint = virtual_network_rule.value.ignore_missing_vnet_service_endpoint
    }
  }

  # Backup configuration
  dynamic "backup" {
    for_each = var.backup != null ? [var.backup] : []
    content {
      type                = backup.value.type
      interval_in_minutes = backup.value.type == "Periodic" ? backup.value.interval_in_minutes : null
      retention_in_hours  = backup.value.type == "Periodic" ? backup.value.retention_in_hours : null
      storage_redundancy  = backup.value.storage_redundancy
      tier                = backup.value.type == "Continuous" ? backup.value.tier : null
    }
  }

  # CORS rules configuration
  dynamic "cors_rule" {
    for_each = var.cors_rules != null ? [var.cors_rules] : []
    content {
      allowed_headers    = cors_rule.value.allowed_headers
      allowed_methods    = cors_rule.value.allowed_methods
      allowed_origins    = cors_rule.value.allowed_origins
      exposed_headers    = cors_rule.value.exposed_headers
      max_age_in_seconds = cors_rule.value.max_age_in_seconds
    }
  }

  # Identity configuration
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.type == "UserAssigned" || identity.value.type == "SystemAssigned, UserAssigned" ? identity.value.identity_ids : null
    }
  }
}
