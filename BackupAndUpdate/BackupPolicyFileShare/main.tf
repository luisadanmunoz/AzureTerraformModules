################################################################################
# Backup Policy for File Shares
################################################################################

resource "azurerm_backup_policy_file_share" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name

  timezone = var.timezone

  # Backup Schedule
  backup {
    frequency = var.backup.frequency
    time      = local.is_daily ? var.backup.time : null

    dynamic "hourly" {
      for_each = local.is_hourly && var.backup.hourly != null ? [var.backup.hourly] : []
      content {
        interval        = hourly.value.interval
        start_time      = hourly.value.start_time
        window_duration = hourly.value.window_duration
      }
    }
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
}
