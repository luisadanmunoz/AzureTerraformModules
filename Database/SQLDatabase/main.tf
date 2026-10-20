################################################################################
# Azure SQL Database
################################################################################

# DEPENDENCY: SQL Server must exist
# DEPENDENCY: Elastic Pool must exist (if using elastic_pool_id)
# DEPENDENCY: Key Vault Key must exist (if using TDE with CMK)
# DEPENDENCY: Source database must exist (if using create_mode Copy/Restore)
# DEPENDENCY: Storage Account must exist (if using threat detection with storage)

resource "azurerm_mssql_database" "this" {
  count = var.create ? 1 : 0

  name      = local.name
  server_id = var.server_id

  # SKU configuration
  sku_name        = var.elastic_pool_id != null ? "ElasticPool" : var.sku_name
  elastic_pool_id = var.elastic_pool_id

  # Database settings
  collation      = var.collation
  license_type   = var.license_type
  max_size_gb    = var.max_size_gb
  read_scale     = var.read_scale
  zone_redundant = var.zone_redundant

  # Serverless configuration
  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  min_capacity                = var.min_capacity

  # Features
  ledger_enabled     = var.ledger_enabled
  geo_backup_enabled = var.geo_backup_enabled

  # Backup storage
  storage_account_type = var.storage_account_type

  # Creation mode
  create_mode                 = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  restore_point_in_time       = var.restore_point_in_time
  recover_database_id         = var.recover_database_id
  restore_dropped_database_id = var.restore_dropped_database_id

  # Transparent Data Encryption
  transparent_data_encryption_enabled                        = var.transparent_data_encryption_enabled
  transparent_data_encryption_key_vault_key_id               = var.transparent_data_encryption_key_vault_key_id
  transparent_data_encryption_key_automatic_rotation_enabled = var.transparent_data_encryption_key_automatic_rotation_enabled

  # Identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # Short-term retention
  dynamic "short_term_retention_policy" {
    for_each = var.short_term_retention_policy != null ? [var.short_term_retention_policy] : []

    content {
      retention_days           = short_term_retention_policy.value.retention_days
      backup_interval_in_hours = short_term_retention_policy.value.backup_interval_in_hours
    }
  }

  # Long-term retention
  dynamic "long_term_retention_policy" {
    for_each = var.long_term_retention_policy != null ? [var.long_term_retention_policy] : []

    content {
      weekly_retention  = long_term_retention_policy.value.weekly_retention
      monthly_retention = long_term_retention_policy.value.monthly_retention
      yearly_retention  = long_term_retention_policy.value.yearly_retention
      week_of_year      = long_term_retention_policy.value.week_of_year
    }
  }

  # Threat detection
  dynamic "threat_detection_policy" {
    for_each = var.threat_detection_policy != null ? [var.threat_detection_policy] : []

    content {
      state                      = threat_detection_policy.value.state
      disabled_alerts            = threat_detection_policy.value.disabled_alerts
      email_account_admins       = threat_detection_policy.value.email_account_admins
      email_addresses            = threat_detection_policy.value.email_addresses
      retention_days             = threat_detection_policy.value.retention_days
      storage_endpoint           = threat_detection_policy.value.storage_endpoint
      storage_account_access_key = threat_detection_policy.value.storage_account_access_key
    }
  }

  tags = local.tags
}
