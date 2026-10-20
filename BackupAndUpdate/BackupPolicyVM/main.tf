################################################################################
# Backup Policy for VMs
################################################################################

resource "azurerm_backup_policy_vm" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name

  policy_type = var.policy_type
  timezone    = var.timezone

  instant_restore_retention_days = var.instant_restore_retention_days

  # Instant Restore Resource Group
  dynamic "instant_restore_resource_group" {
    for_each = var.instant_restore_resource_group != null ? [var.instant_restore_resource_group] : []
    content {
      prefix = instant_restore_resource_group.value.prefix
      suffix = instant_restore_resource_group.value.suffix
    }
  }

  # Backup Schedule
  backup {
    frequency     = var.backup.frequency
    time          = local.is_hourly ? null : var.backup.time
    hour_interval = local.is_hourly ? var.backup.hour_interval : null
    hour_duration = local.is_hourly ? var.backup.hour_duration : null
    weekdays      = local.is_weekly ? var.backup.weekdays : null
  }

  # Daily Retention
  retention_daily {
    count = var.retention_daily
  }

  # Weekly Retention
  dynamic "retention_weekly" {
    for_each = var.retention_weekly != null ? [var.retention_weekly] : []
    content {
      count    = retention_weekly.value.count
      weekdays = retention_weekly.value.weekdays
    }
  }

  # Monthly Retention
  dynamic "retention_monthly" {
    for_each = var.retention_monthly != null ? [var.retention_monthly] : []
    content {
      count             = retention_monthly.value.count
      weekdays          = retention_monthly.value.weekdays
      weeks             = retention_monthly.value.weeks
      days              = retention_monthly.value.days
      include_last_days = retention_monthly.value.include_last_days
    }
  }

  # Yearly Retention
  dynamic "retention_yearly" {
    for_each = var.retention_yearly != null ? [var.retention_yearly] : []
    content {
      count             = retention_yearly.value.count
      months            = retention_yearly.value.months
      weekdays          = retention_yearly.value.weekdays
      weeks             = retention_yearly.value.weeks
      days              = retention_yearly.value.days
      include_last_days = retention_yearly.value.include_last_days
    }
  }

  # Tiering Policy
  dynamic "tiering_policy" {
    for_each = var.tiering_policy != null ? [var.tiering_policy] : []
    content {
      dynamic "archived_restore_point" {
        for_each = tiering_policy.value.archive_tier != null ? [tiering_policy.value.archive_tier] : []
        content {
          mode          = archived_restore_point.value.mode
          duration      = archived_restore_point.value.duration
          duration_type = archived_restore_point.value.duration_type
        }
      }
    }
  }
}
