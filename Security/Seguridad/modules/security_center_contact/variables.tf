#############################################################################
# VARIABLES SECURITY CENTER CONTACT
#############################################################################
variable "security_center_contact_name" {
  description = "value to set the security center contact name"
  type        = string
}

variable "email" {
  description = "value to set the email"
  type        = string
}

variable "alert_notifications" {
  description = "value to set the alert notifications"
  type        = bool
}

variable "alerts_to_admins" {
  description = "value to set the alerts to admins"
  type        = bool
}

variable "phone" {
  description = "value to set the phone"
  type        = string
  default     = null
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
