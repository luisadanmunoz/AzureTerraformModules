#############################################################################
# VARIABLES LOG ANALYTICS WORKSPACE
#############################################################################
variable "log_analytics_workspace_name" {
  description = "value to set the log analytics workspace name"
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

variable "sku" {
  description = "value to set the sku"
  type        = string
  default     = null
}

variable "retention_in_days" {
  description = "value to set the retention in days"
  type        = number
  default     = null
}

variable "daily_quota_gb" {
  description = "value to set the daily quota gb"
  type        = number
  default     = null
}

variable "reservation_capacity_in_gb_per_day" {
  description = "value to set the reservation capacity in gb per day"
  type        = number
  default     = null
}

variable "internet_ingestion_enabled" {
  description = "value to set the internet ingestion enabled flag"
  type        = bool
  default     = null
}

variable "internet_query_enabled" {
  description = "value to set the internet query enabled flag"
  type        = bool
  default     = null
}

variable "local_authentication_enabled" {
  description = "value to set the local authentication enabled flag"
  type        = bool
  default     = null
}

variable "allow_resource_only_permissions" {
  description = "value to set the allow resource only permissions flag"
  type        = bool
  default     = null
}

variable "cmk_for_query_forced" {
  description = "value to set the cmk for query forced flag"
  type        = bool
  default     = null
}

variable "data_collection_rule_id" {
  description = "value to set the data collection rule id"
  type        = string
  default     = null
}

variable "immediate_data_purge_on_30_days_enabled" {
  description = "value to set the immediate data purge on 30 days enabled flag"
  type        = bool
  default     = null
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
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
