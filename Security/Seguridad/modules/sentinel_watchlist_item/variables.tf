#############################################################################
# VARIABLES SENTINEL WATCHLIST ITEM
#############################################################################
variable "watchlist_id" {
  description = "value to set the watchlist id"
  type        = string
}

variable "name" {
  description = "value to set the name"
  type        = string
  default     = null
}

variable "properties" {
  description = "value to set the properties"
  type        = map(string)
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
