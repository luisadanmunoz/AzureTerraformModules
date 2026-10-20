################################################################################
# Azure Database for PostgreSQL - Flexible Server
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Subnet must exist with delegation to Microsoft.DBforPostgreSQL/flexibleServers (if using VNet)
# DEPENDENCY: Private DNS Zone must exist (if using VNet)
# DEPENDENCY: Key Vault Key must exist (if using CMK)
# DEPENDENCY: User Assigned Identity must exist (if using UserAssigned identity)

resource "azurerm_postgresql_flexible_server" "this" {
  count = var.create ? 1 : 0

  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location

  # Version and SKU
  version  = var.version
  sku_name = var.sku_name

  # Storage
  storage_mb        = var.storage_mb
  storage_tier      = var.storage_tier
  auto_grow_enabled = var.auto_grow_enabled

  # Availability
  zone = var.zone

  # Backup
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  backup_retention_days        = var.backup_retention_days

  # Authentication
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  # Authentication configuration
  dynamic "authentication" {
    for_each = var.authentication != null ? [var.authentication] : []

    content {
      active_directory_auth_enabled = authentication.value.active_directory_auth_enabled
      password_auth_enabled         = authentication.value.password_auth_enabled
      tenant_id                     = authentication.value.tenant_id
    }
  }

  # Network
  delegated_subnet_id           = var.delegated_subnet_id
  private_dns_zone_id           = var.private_dns_zone_id
  public_network_access_enabled = var.public_network_access_enabled

  # High availability
  dynamic "high_availability" {
    for_each = var.high_availability != null ? [var.high_availability] : []

    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = high_availability.value.standby_availability_zone
    }
  }

  # Maintenance window
  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []

    content {
      day_of_week  = maintenance_window.value.day_of_week
      start_hour   = maintenance_window.value.start_hour
      start_minute = maintenance_window.value.start_minute
    }
  }

  # Customer managed key
  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []

    content {
      key_vault_key_id                     = customer_managed_key.value.key_vault_key_id
      primary_user_assigned_identity_id    = customer_managed_key.value.primary_user_assigned_identity_id
      geo_backup_key_vault_key_id          = customer_managed_key.value.geo_backup_key_vault_key_id
      geo_backup_user_assigned_identity_id = customer_managed_key.value.geo_backup_user_assigned_identity_id
    }
  }

  # Identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  tags = local.tags
}

################################################################################
# Databases
################################################################################

resource "azurerm_postgresql_flexible_server_database" "this" {
  for_each = var.create ? { for db in var.databases : db.name => db } : {}

  name      = each.value.name
  server_id = azurerm_postgresql_flexible_server.this[0].id
  charset   = each.value.charset
  collation = each.value.collation
}

################################################################################
# Server Configurations
################################################################################

resource "azurerm_postgresql_flexible_server_configuration" "this" {
  for_each = var.create ? var.server_configurations : {}

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.this[0].id
  value     = each.value
}

################################################################################
# Firewall Rules
################################################################################

resource "azurerm_postgresql_flexible_server_firewall_rule" "this" {
  for_each = var.create ? { for rule in var.firewall_rules : rule.name => rule } : {}

  name             = each.value.name
  server_id        = azurerm_postgresql_flexible_server.this[0].id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}
