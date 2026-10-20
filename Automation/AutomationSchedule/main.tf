################################################################################
# Automation Schedule
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_schedule" "this" {
  count = var.create ? 1 : 0

  name                    = var.name
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  description             = var.description

  # ──────────────────────────────────────────────────────────────────────────────
  # Frequency Configuration
  # ──────────────────────────────────────────────────────────────────────────────
  frequency = var.frequency
  interval  = var.frequency != "OneTime" ? var.interval : null

  # ──────────────────────────────────────────────────────────────────────────────
  # Time Configuration
  # ──────────────────────────────────────────────────────────────────────────────
  start_time  = var.start_time
  expiry_time = var.expiry_time
  timezone    = var.timezone

  # ──────────────────────────────────────────────────────────────────────────────
  # Weekly Schedule
  # ──────────────────────────────────────────────────────────────────────────────
  week_days = var.frequency == "Week" ? var.week_days : null

  # ──────────────────────────────────────────────────────────────────────────────
  # Monthly Schedule
  # ──────────────────────────────────────────────────────────────────────────────
  month_days = var.frequency == "Month" && var.monthly_occurrence == null ? var.month_days : null

  dynamic "monthly_occurrence" {
    for_each = var.frequency == "Month" && var.monthly_occurrence != null ? [var.monthly_occurrence] : []
    content {
      day        = monthly_occurrence.value.day
      occurrence = monthly_occurrence.value.occurrence
    }
  }
}
