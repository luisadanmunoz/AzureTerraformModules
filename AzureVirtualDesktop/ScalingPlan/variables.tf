################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the AVD Scaling Plan."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Scaling Plan should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Scaling Plan. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'vdscaling'."
  type        = string
  default     = "vdscaling"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "avd"
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
# Scaling Plan Configuration
################################################################################

variable "friendly_name" {
  description = "(Optional) A friendly name for the Scaling Plan."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) A description for the Scaling Plan."
  type        = string
  default     = null
}

variable "time_zone" {
  description = "(Required) The timezone for the Scaling Plan schedules."
  type        = string
  default     = "UTC"
}

variable "exclusion_tag" {
  description = "(Optional) Tag name to exclude VMs from scaling."
  type        = string
  default     = null
}

################################################################################
# Host Pool Associations
################################################################################

variable "host_pool_associations" {
  description = <<-EOT
    (Optional) List of Host Pool associations.
    - hostpool_id: The ID of the Host Pool. DEPENDENCY: Host Pool must exist.
    - enabled: Whether scaling is enabled for this host pool.
  EOT
  type = list(object({
    hostpool_id = string
    enabled     = optional(bool, true)
  }))
  default = []
}

################################################################################
# Schedules
################################################################################

variable "schedules" {
  description = <<-EOT
    (Required) List of scaling schedules.
    - name: Name of the schedule.
    - days_of_week: Days the schedule applies (Monday, Tuesday, etc.).
    - ramp_up_*: Ramp-up period settings.
    - peak_*: Peak hours settings.
    - ramp_down_*: Ramp-down period settings.
    - off_peak_*: Off-peak hours settings.
  EOT
  type = list(object({
    name         = string
    days_of_week = list(string)

    # Ramp-up settings
    ramp_up_start_time                 = string
    ramp_up_load_balancing_algorithm   = optional(string, "BreadthFirst")
    ramp_up_minimum_hosts_percent      = optional(number, 20)
    ramp_up_capacity_threshold_percent = optional(number, 60)

    # Peak settings
    peak_start_time                 = string
    peak_load_balancing_algorithm   = optional(string, "BreadthFirst")

    # Ramp-down settings
    ramp_down_start_time                    = string
    ramp_down_load_balancing_algorithm      = optional(string, "DepthFirst")
    ramp_down_minimum_hosts_percent         = optional(number, 10)
    ramp_down_capacity_threshold_percent    = optional(number, 90)
    ramp_down_force_logoff_users            = optional(bool, false)
    ramp_down_wait_time_minutes             = optional(number, 30)
    ramp_down_notification_message          = optional(string, "You will be logged off in 30 minutes. Please save your work.")
    ramp_down_stop_hosts_when               = optional(string, "ZeroSessions")

    # Off-peak settings
    off_peak_start_time                 = string
    off_peak_load_balancing_algorithm   = optional(string, "DepthFirst")
  }))
  default = []

  validation {
    condition     = length(var.schedules) > 0 || !var.create
    error_message = "At least one schedule must be provided when create is true."
  }
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
