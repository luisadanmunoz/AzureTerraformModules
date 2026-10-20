#############################################################################
# VARIABLES SENTINEL WATCHLIST
#############################################################################
variable "sentinel_watchlist_name" {
  description = "value to set the sentinel watchlist name"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "value to set the log analytics workspace id"
  type        = string
}

variable "display_name" {
  description = "value to set the display name"
  type        = string
}

variable "item_search_key" {
  description = "value to set the item search key"
  type        = string
}

variable "default_duration" {
  description = "value to set the default duration"
  type        = string
  default     = null
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "labels" {
  description = "value to set the labels"
  type        = list(string)
  default     = null
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    delete = optional(string)
  })
  default = null
}
