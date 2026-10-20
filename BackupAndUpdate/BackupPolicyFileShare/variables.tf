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
  default     = "fileshare"
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

variable "timezone" {
  description = "(Optional) The timezone for the backup schedule. Default: UTC."
  type        = string
  default     = "UTC"
}

################################################################################
# Backup Schedule
################################################################################

variable "backup" {
  description = <<-EOT
    (Required) Backup schedule configuration.
    - frequency: Backup frequency. Values: Hourly, Daily.
    - time: Time of backup in 24h format (e.g., "23:00"). Required for Daily.
    - hourly: Hourly backup configuration.
      - interval: Hours between backups (4, 6, 8, 12).
      - start_time: Start time in 24h format.
      - window_duration: Backup window in hours.
  EOT
  type = object({
    frequency = string
    time      = optional(string, "23:00")
    hourly = optional(object({
      interval        = number
      start_time      = string
      window_duration = number
    }), null)
  })

  validation {
    condition     = contains(["Hourly", "Daily"], var.backup.frequency)
    error_message = "backup.frequency must be Hourly or Daily."
  }
}

################################################################################
# Retention Policies
################################################################################

variable "retention_daily" {
  description = "(Required) Number of daily backups to retain. 1-200."
  type        = number
  default     = 30

  validation {
    condition     = var.retention_daily >= 1 && var.retention_daily <= 200
    error_message = "retention_daily must be between 1 and 200."
  }
}

variable "retention_weekly" {
  description = <<-EOT
    (Optional) Weekly retention configuration.
    - count: Number of weekly backups to retain. 1-200.
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
    - count: Number of monthly backups to retain. 1-120.
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
    - count: Number of yearly backups to retain. 1-10.
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
