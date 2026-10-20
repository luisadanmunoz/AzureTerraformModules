#############################################################################
# VARIABLES VIRTUAL DESKTOP SCALING PLAN
#############################################################################
variable "virtual_desktop_scaling_plan_name" {
  description = "value to set the virtual desktop scaling plan name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "time_zone" {
  description = "value to set the time zone"
  type        = string
}

variable "friendly_name" {
  description = "value to set the friendly name"
  type        = string
  default     = null
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "exclusion_tag" {
  description = "value to set the exclusion tag"
  type        = string
  default     = null
}

variable "host_pool" {
  description = "value to set the host pool inline associations"
  type = list(object({
    hostpool_id          = string
    scaling_plan_enabled = bool
  }))
  default = null
}

variable "schedule" {
  description = "value to set the schedules"
  type = list(object({
    name                                 = string
    days_of_week                         = list(string)
    ramp_up_start_time                   = string
    ramp_up_load_balancing_algorithm     = string
    ramp_up_minimum_hosts_percent        = optional(number)
    ramp_up_capacity_threshold_percent   = optional(number)
    peak_start_time                      = string
    peak_load_balancing_algorithm        = string
    ramp_down_start_time                 = string
    ramp_down_load_balancing_algorithm   = string
    ramp_down_minimum_hosts_percent      = number
    ramp_down_force_logoff_users         = bool
    ramp_down_wait_time_minutes          = number
    ramp_down_notification_message       = string
    ramp_down_capacity_threshold_percent = number
    ramp_down_stop_hosts_when            = string
    off_peak_start_time                  = string
    off_peak_load_balancing_algorithm    = string
  }))
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
