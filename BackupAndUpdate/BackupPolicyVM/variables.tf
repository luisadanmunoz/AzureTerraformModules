################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Backup Policy."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "recovery_vault_name" {
  description = "(Required) The name of the Recovery Services Vault. DEPENDENCY: Vault must exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Backup Policy. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'bkpol'."
  type        = string
  default     = "bkpol"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "vm"
}

variable "environment" {
  description = "(Optional) Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number for the naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Policy Configuration
################################################################################

variable "policy_type" {
  description = "(Optional) Policy type. Values: V1, V2. V2 supports hourly backups. Default: V2."
  type        = string
  default     = "V2"

  validation {
    condition     = contains(["V1", "V2"], var.policy_type)
    error_message = "policy_type must be V1 or V2."
  }
}

variable "timezone" {
  description = "(Optional) The timezone for the backup schedule. Default: UTC."
  type        = string
  default     = "UTC"
}

variable "instant_restore_retention_days" {
  description = "(Optional) Instant restore snapshot retention in days. 1-5 for V1, 1-30 for V2. Default: 2."
  type        = number
  default     = 2
}

variable "instant_restore_resource_group" {
  description = <<-EOT
    (Optional) Resource group for instant restore snapshots.
    - prefix: Prefix for the resource group name.
    - suffix: Suffix for the resource group name.
  EOT
  type = object({
    prefix = optional(string, null)
    suffix = optional(string, null)
  })
  default = null
}

################################################################################
# Backup Schedule
################################################################################

variable "backup" {
  description = <<-EOT
    (Required) Backup schedule configuration.
    - frequency: Backup frequency. Values: Hourly, Daily, Weekly.
    - time: Time of backup in 24h format (e.g., "23:00"). Required for Daily/Weekly.
    - hour_interval: Hours between backups (4, 6, 8, 12). Required for Hourly.
    - hour_duration: Duration window in hours (4-24). Required for Hourly.
    - weekdays: Days for weekly backup.
  EOT
  type = object({
    frequency     = string
    time          = optional(string, "23:00")
    hour_interval = optional(number, null)
    hour_duration = optional(number, null)
    weekdays      = optional(list(string), null)
  })

  validation {
    condition     = contains(["Hourly", "Daily", "Weekly"], var.backup.frequency)
    error_message = "backup.frequency must be Hourly, Daily, or Weekly."
  }
}

################################################################################
# Retention Policies
################################################################################

variable "retention_daily" {
  description = "(Optional) Number of daily backups to retain. 7-9999."
  type        = number
  default     = 7

  validation {
    condition     = var.retention_daily >= 7 && var.retention_daily <= 9999
    error_message = "retention_daily must be between 7 and 9999."
  }
}

variable "retention_weekly" {
  description = <<-EOT
    (Optional) Weekly retention configuration.
    - count: Number of weekly backups to retain. 1-5163.
    - weekdays: Days of week to retain.
  EOT
  type = object({
    count    = number
    weekdays = list(string)
  })
  default = null
}

variable "retention_monthly" {
  description = <<-EOT
    (Optional) Monthly retention configuration.
    - count: Number of monthly backups to retain. 1-1188.
    - weekdays: Days of week to retain.
    - weeks: Weeks of month (First, Second, Third, Fourth, Last).
    - days: Specific days of month (1-31).
    - include_last_days: Include last day of month.
  EOT
  type = object({
    count             = number
    weekdays          = optional(list(string), null)
    weeks             = optional(list(string), null)
    days              = optional(list(number), null)
    include_last_days = optional(bool, false)
  })
  default = null
}

variable "retention_yearly" {
  description = <<-EOT
    (Optional) Yearly retention configuration.
    - count: Number of yearly backups to retain. 1-99.
    - months: Months to retain backup.
    - weekdays: Days of week to retain.
    - weeks: Weeks of month.
    - days: Specific days of month.
    - include_last_days: Include last day of month.
  EOT
  type = object({
    count             = number
    months            = list(string)
    weekdays          = optional(list(string), null)
    weeks             = optional(list(string), null)
    days              = optional(list(number), null)
    include_last_days = optional(bool, false)
  })
  default = null
}

################################################################################
# Tiering Policy
################################################################################

variable "tiering_policy" {
  description = <<-EOT
    (Optional) Tiering policy for Archive tier.
    - archive_tier: Archive tier configuration.
      - mode: TierRecommended or TierAfter.
      - duration: Days/Weeks/Months after which to tier.
      - duration_type: Days, Weeks, or Months.
  EOT
  type = object({
    archive_tier = optional(object({
      mode          = string
      duration      = optional(number, null)
      duration_type = optional(string, null)
    }), null)
  })
  default = null
}
