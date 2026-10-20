################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Schedule."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "automation_account_name" {
  description = "(Required) The name of the Automation Account where the Schedule will be created. DEPENDENCY: Automation Account must exist."
  type        = string
}

################################################################################
# Schedule Configuration
################################################################################

variable "name" {
  description = "(Required) The name of the Schedule."
  type        = string
}

variable "description" {
  description = "(Optional) A description for this Schedule."
  type        = string
  default     = null
}

variable "frequency" {
  description = "(Required) The frequency of the Schedule. Possible values: OneTime, Hour, Day, Week, Month."
  type        = string

  validation {
    condition     = contains(["OneTime", "Hour", "Day", "Week", "Month"], var.frequency)
    error_message = "frequency must be one of: OneTime, Hour, Day, Week, Month."
  }
}

variable "interval" {
  description = "(Optional) The number of frequency intervals between runs. Required for Hour, Day, Week, Month frequencies. Valid range: 1-100."
  type        = number
  default     = null

  validation {
    condition     = var.interval == null || (var.interval >= 1 && var.interval <= 100)
    error_message = "interval must be between 1 and 100."
  }
}

variable "start_time" {
  description = "(Optional) Start time of the Schedule in RFC3339 format (e.g., 2024-01-01T06:00:00+00:00). Must be at least 5 minutes in the future. Defaults to 7 minutes from now."
  type        = string
  default     = null
}

variable "expiry_time" {
  description = "(Optional) End time of the Schedule in RFC3339 format. Schedule will not run after this time."
  type        = string
  default     = null
}

variable "timezone" {
  description = "(Optional) The timezone of the Schedule. Default: UTC. Examples: UTC, Europe/Madrid, America/New_York."
  type        = string
  default     = "UTC"
}

################################################################################
# Weekly Schedule
################################################################################

variable "week_days" {
  description = "(Optional) List of days of the week for weekly schedules. Values: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday."
  type        = list(string)
  default     = null

  validation {
    condition = var.week_days == null || alltrue([
      for day in coalesce(var.week_days, []) :
      contains(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], day)
    ])
    error_message = "week_days must contain valid day names: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday."
  }
}

################################################################################
# Monthly Schedule
################################################################################

variable "month_days" {
  description = "(Optional) List of days of the month for monthly schedules. Values: 1-31, or -1 for last day."
  type        = list(number)
  default     = null

  validation {
    condition = var.month_days == null || alltrue([
      for day in coalesce(var.month_days, []) :
      (day >= 1 && day <= 31) || day == -1
    ])
    error_message = "month_days must contain values between 1-31, or -1 for last day of month."
  }
}

variable "monthly_occurrence" {
  description = <<-EOT
    (Optional) Monthly occurrence for schedules that run on a specific week day.
    - day: (Required) Day of the week. Values: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday.
    - occurrence: (Required) Week of the month. Values: 1 (First), 2 (Second), 3 (Third), 4 (Fourth), -1 (Last).
  EOT
  type = object({
    day        = string
    occurrence = number
  })
  default = null

  validation {
    condition = var.monthly_occurrence == null || (
      contains(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], var.monthly_occurrence.day) &&
      contains([1, 2, 3, 4, -1], var.monthly_occurrence.occurrence)
    )
    error_message = "monthly_occurrence.day must be a valid day name and occurrence must be 1, 2, 3, 4, or -1."
  }
}
