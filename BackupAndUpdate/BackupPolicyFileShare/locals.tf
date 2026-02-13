################################################################################
# Local Values
################################################################################

locals {
  # Naming
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  resource_name  = var.name != null ? var.name : local.generated_name

  # Backup frequency flags
  is_hourly = var.backup.frequency == "Hourly"
  is_daily  = var.backup.frequency == "Daily"
}
