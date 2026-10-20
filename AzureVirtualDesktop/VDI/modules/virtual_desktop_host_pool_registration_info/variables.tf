#############################################################################
# VARIABLES VIRTUAL DESKTOP HOST POOL REGISTRATION INFO
#############################################################################
variable "hostpool_id" {
  description = "value to set the host pool id"
  type        = string
}

variable "expiration_date" {
  description = "value to set the expiration date"
  type        = string
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
