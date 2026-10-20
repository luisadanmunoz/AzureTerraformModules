#############################################################################
# VARIABLES SECURITY CENTER SETTING
#############################################################################
variable "setting_name" {
  description = "value to set the setting name"
  type        = string

  validation {
    condition     = contains(["MCAS", "Sentinel"], var.setting_name)
    error_message = "The security_center_setting setting_name must be either MCAS or Sentinel."
  }
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
