#############################################################################
# VARIABLES SECURITY CENTER AUTO PROVISIONING
#############################################################################
variable "auto_provision" {
  description = "value to set the auto provision mode"
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
