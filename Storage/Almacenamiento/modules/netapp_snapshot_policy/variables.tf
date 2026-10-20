#############################################################################
# VARIABLES NETAPP SNAPSHOT POLICY
#############################################################################
variable "netapp_snapshot_policy_name" {
  description = "value to set the netapp snapshot policy name"
  type        = string
}

variable "account_name" {
  description = "value to set the account name"
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

variable "enabled" {
  description = "value to set the enabled"
  type        = bool
}

variable "hourly_schedule" {
  description = "value to set the hourly schedule"
  type = object({
    minute            = number
    snapshots_to_keep = number
  })
  default = null
}

variable "daily_schedule" {
  description = "value to set the daily schedule"
  type = object({
    hour              = number
    minute            = number
    snapshots_to_keep = number
  })
  default = null
}

variable "weekly_schedule" {
  description = "value to set the weekly schedule"
  type = object({
    days_of_week      = list(string)
    hour              = number
    minute            = number
    snapshots_to_keep = number
  })
  default = null
}

variable "monthly_schedule" {
  description = "value to set the monthly schedule"
  type = object({
    days_of_month     = list(number)
    hour              = number
    minute            = number
    snapshots_to_keep = number
  })
  default = null
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
