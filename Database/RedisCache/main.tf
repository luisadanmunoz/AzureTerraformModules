################################################################################
# Azure Redis Cache
################################################################################

resource "azurerm_redis_cache" "this" {
  count = var.create ? 1 : 0

  name                          = local.cache_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  capacity                      = var.capacity
  family                        = var.family
  sku_name                      = var.sku_name
  redis_version                 = var.redis_version
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  enable_non_ssl_port           = var.enable_non_ssl_port

  # Premium SKU features
  subnet_id                 = var.subnet_id
  private_static_ip_address = var.private_static_ip_address
  shard_count               = var.shard_count
  replicas_per_master       = var.replicas_per_master
  replicas_per_primary      = var.replicas_per_primary
  zones                     = var.zones

  dynamic "redis_configuration" {
    for_each = var.redis_configuration != null ? [var.redis_configuration] : []
    content {
      aof_backup_enabled                      = redis_configuration.value.aof_backup_enabled
      aof_storage_connection_string_0         = redis_configuration.value.aof_storage_connection_string_0
      aof_storage_connection_string_1         = redis_configuration.value.aof_storage_connection_string_1
      enable_authentication                   = redis_configuration.value.enable_authentication
      active_directory_authentication_enabled = redis_configuration.value.active_directory_authentication_enabled
      maxmemory_reserved                      = redis_configuration.value.maxmemory_reserved
      maxmemory_delta                         = redis_configuration.value.maxmemory_delta
      maxmemory_policy                        = redis_configuration.value.maxmemory_policy
      maxfragmentationmemory_reserved         = redis_configuration.value.maxfragmentationmemory_reserved
      rdb_backup_enabled                      = redis_configuration.value.rdb_backup_enabled
      rdb_backup_frequency                    = redis_configuration.value.rdb_backup_frequency
      rdb_backup_max_snapshot_count           = redis_configuration.value.rdb_backup_max_snapshot_count
      rdb_storage_connection_string           = redis_configuration.value.rdb_storage_connection_string
      notify_keyspace_events                  = redis_configuration.value.notify_keyspace_events
    }
  }

  dynamic "patch_schedule" {
    for_each = var.patch_schedules
    content {
      day_of_week        = patch_schedule.value.day_of_week
      start_hour_utc     = patch_schedule.value.start_hour_utc
      maintenance_window = patch_schedule.value.maintenance_window
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      redis_configuration[0].rdb_storage_connection_string,
      redis_configuration[0].aof_storage_connection_string_0,
      redis_configuration[0].aof_storage_connection_string_1,
    ]
  }
}

################################################################################
# Firewall Rules
################################################################################

resource "azurerm_redis_firewall_rule" "this" {
  for_each = var.create ? { for rule in var.firewall_rules : rule.name => rule } : {}

  name                = each.value.name
  redis_cache_name    = azurerm_redis_cache.this[0].name
  resource_group_name = var.resource_group_name
  start_ip            = each.value.start_ip
  end_ip              = each.value.end_ip
}
