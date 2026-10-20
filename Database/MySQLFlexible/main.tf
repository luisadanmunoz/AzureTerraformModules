################################################################################
# Azure MySQL Flexible Server
################################################################################

resource "azurerm_mysql_flexible_server" "this" {
  count = var.create ? 1 : 0

  name                = local.server_name
  resource_group_name = var.resource_group_name
  location            = var.location

  version                       = var.version
  sku_name                      = var.sku_name
  administrator_login           = var.administrator_login
  administrator_password        = var.administrator_password
  zone                          = var.zone
  backup_retention_days         = var.backup_retention_days
  geo_redundant_backup_enabled  = var.geo_redundant_backup_enabled
  delegated_subnet_id           = var.delegated_subnet_id
  private_dns_zone_id           = var.private_dns_zone_id

  dynamic "storage" {
    for_each = var.storage != null ? [var.storage] : []
    content {
      auto_grow_enabled  = storage.value.auto_grow_enabled
      io_scaling_enabled = storage.value.io_scaling_enabled
      iops               = storage.value.iops
      size_gb            = storage.value.size_gb
    }
  }

  dynamic "high_availability" {
    for_each = var.high_availability != null ? [var.high_availability] : []
    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = high_availability.value.standby_availability_zone
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []
    content {
      day_of_week  = maintenance_window.value.day_of_week
      start_hour   = maintenance_window.value.start_hour
      start_minute = maintenance_window.value.start_minute
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []
    content {
      key_vault_key_id                     = customer_managed_key.value.key_vault_key_id
      primary_user_assigned_identity_id    = customer_managed_key.value.primary_user_assigned_identity_id
      geo_backup_key_vault_key_id          = customer_managed_key.value.geo_backup_key_vault_key_id
      geo_backup_user_assigned_identity_id = customer_managed_key.value.geo_backup_user_assigned_identity_id
    }
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      zone,
      high_availability[0].standby_availability_zone,
    ]
  }
}

################################################################################
# Server Configurations
################################################################################

resource "azurerm_mysql_flexible_server_configuration" "this" {
  for_each = var.create && length(var.server_configurations) > 0 ? var.server_configurations : {}

  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.this[0].name
  value               = each.value
}

################################################################################
# Databases
################################################################################

resource "azurerm_mysql_flexible_database" "this" {
  for_each = var.create ? { for db in var.databases : db.name => db } : {}

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.this[0].name
  charset             = each.value.charset
  collation           = each.value.collation
}

################################################################################
# Firewall Rules
################################################################################

resource "azurerm_mysql_flexible_server_firewall_rule" "this" {
  for_each = var.create ? { for rule in var.firewall_rules : rule.name => rule } : {}

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.this[0].name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}
