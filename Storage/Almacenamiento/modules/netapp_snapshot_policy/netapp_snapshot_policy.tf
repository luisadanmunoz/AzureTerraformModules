#############################################################################
# NETAPP SNAPSHOT POLICY
#############################################################################
resource "azurerm_netapp_snapshot_policy" "netapp_snapshot_policy" {
  name                = var.netapp_snapshot_policy_name
  account_name        = var.account_name
  resource_group_name = var.resource_group_name
  location            = var.location
  enabled             = var.enabled
  tags                = var.tags

  dynamic "hourly_schedule" {
    for_each = var.hourly_schedule != null ? [var.hourly_schedule] : []

    content {
      minute            = hourly_schedule.value["minute"]
      snapshots_to_keep = hourly_schedule.value["snapshots_to_keep"]
    }
  }

  dynamic "daily_schedule" {
    for_each = var.daily_schedule != null ? [var.daily_schedule] : []

    content {
      hour              = daily_schedule.value["hour"]
      minute            = daily_schedule.value["minute"]
      snapshots_to_keep = daily_schedule.value["snapshots_to_keep"]
    }
  }

  dynamic "weekly_schedule" {
    for_each = var.weekly_schedule != null ? [var.weekly_schedule] : []

    content {
      days_of_week      = weekly_schedule.value["days_of_week"]
      hour              = weekly_schedule.value["hour"]
      minute            = weekly_schedule.value["minute"]
      snapshots_to_keep = weekly_schedule.value["snapshots_to_keep"]
    }
  }

  dynamic "monthly_schedule" {
    for_each = var.monthly_schedule != null ? [var.monthly_schedule] : []

    content {
      days_of_month     = monthly_schedule.value["days_of_month"]
      hour              = monthly_schedule.value["hour"]
      minute            = monthly_schedule.value["minute"]
      snapshots_to_keep = monthly_schedule.value["snapshots_to_keep"]
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
