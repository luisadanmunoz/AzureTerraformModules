#############################################################################
# VARIABLES VIRTUAL DESKTOP SCALING PLAN HOST POOL ASSOCIATION
#############################################################################
variable "host_pool_id" {
  description = "value to set the host pool id"
  type        = string
}

variable "scaling_plan_id" {
  description = "value to set the scaling plan id"
  type        = string
}

variable "enabled" {
  description = "value to set the enabled flag"
  type        = bool
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
