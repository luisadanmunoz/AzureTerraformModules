#############################################################################
# VARIABLES SENTINEL LOG ANALYTICS WORKSPACE ONBOARDING
#############################################################################
variable "workspace_id" {
  description = "value to set the workspace id"
  type        = string
}

variable "customer_managed_key_enabled" {
  description = "value to set the customer managed key enabled flag"
  type        = bool
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
