################################################################################
# Required Variables
################################################################################

variable "display_name" {
  description = "The display name of the device enrollment configuration."
  type        = string
}

variable "config_type" {
  description = "The type of enrollment configuration. Possible values are deviceEnrollmentLimitConfiguration, deviceEnrollmentPlatformRestrictionsConfiguration, deviceEnrollmentWindowsHelloForBusinessConfiguration."
  type        = string

  validation {
    condition = contains([
      "deviceEnrollmentLimitConfiguration",
      "deviceEnrollmentPlatformRestrictionsConfiguration",
      "deviceEnrollmentWindowsHelloForBusinessConfiguration"
    ], var.config_type)
    error_message = "The config_type must be one of: deviceEnrollmentLimitConfiguration, deviceEnrollmentPlatformRestrictionsConfiguration, deviceEnrollmentWindowsHelloForBusinessConfiguration."
  }
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the device enrollment configuration resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - Basic Configuration
################################################################################

variable "description" {
  description = "The description of the device enrollment configuration."
  type        = string
  default     = null
}

variable "priority" {
  description = "The priority of the configuration."
  type        = number
  default     = null
}

################################################################################
# Optional - Device Enrollment Limit Configuration
################################################################################

variable "device_limit" {
  description = "The maximum number of devices a user can enroll."
  type        = number
  default     = 5
}

################################################################################
# Optional - Platform Restrictions Configuration
################################################################################

variable "platform_restrictions" {
  description = "Platform restrictions configuration."
  type = object({
    android_restriction = optional(object({
      platform_blocked                   = optional(bool, false)
      personal_device_enrollment_blocked = optional(bool, false)
      os_minimum_version                 = optional(string)
      os_maximum_version                 = optional(string)
      blocked_manufacturers              = optional(list(string), [])
      blocked_skus                       = optional(list(string), [])
    }))
    android_for_work_restriction = optional(object({
      platform_blocked                   = optional(bool, false)
      personal_device_enrollment_blocked = optional(bool, false)
      os_minimum_version                 = optional(string)
      os_maximum_version                 = optional(string)
      blocked_manufacturers              = optional(list(string), [])
      blocked_skus                       = optional(list(string), [])
    }))
    ios_restriction = optional(object({
      platform_blocked                   = optional(bool, false)
      personal_device_enrollment_blocked = optional(bool, false)
      os_minimum_version                 = optional(string)
      os_maximum_version                 = optional(string)
      blocked_manufacturers              = optional(list(string), [])
      blocked_skus                       = optional(list(string), [])
    }))
    mac_os_restriction = optional(object({
      platform_blocked                   = optional(bool, false)
      personal_device_enrollment_blocked = optional(bool, false)
      os_minimum_version                 = optional(string)
      os_maximum_version                 = optional(string)
      blocked_manufacturers              = optional(list(string), [])
      blocked_skus                       = optional(list(string), [])
    }))
    windows_restriction = optional(object({
      platform_blocked                   = optional(bool, false)
      personal_device_enrollment_blocked = optional(bool, false)
      os_minimum_version                 = optional(string)
      os_maximum_version                 = optional(string)
      blocked_manufacturers              = optional(list(string), [])
      blocked_skus                       = optional(list(string), [])
    }))
    windows_mobile_restriction = optional(object({
      platform_blocked                   = optional(bool, true)
      personal_device_enrollment_blocked = optional(bool, false)
      os_minimum_version                 = optional(string)
      os_maximum_version                 = optional(string)
      blocked_manufacturers              = optional(list(string), [])
      blocked_skus                       = optional(list(string), [])
    }))
  })
  default = null
}

################################################################################
# Optional - Windows Hello for Business Configuration
################################################################################

variable "windows_hello_for_business" {
  description = "Windows Hello for Business configuration."
  type = object({
    state                                     = optional(string, "notConfigured")
    pin_minimum_length                        = optional(number, 4)
    pin_maximum_length                        = optional(number, 127)
    pin_uppercase_characters_usage            = optional(string, "allowed")
    pin_lowercase_characters_usage            = optional(string, "allowed")
    pin_special_characters_usage              = optional(string, "allowed")
    security_device_required                  = optional(bool, false)
    unlock_with_biometrics_enabled            = optional(bool, true)
    remote_passport_enabled                   = optional(bool, true)
    pin_recovery_enabled                      = optional(bool, true)
    pin_expiration_in_days                    = optional(number, 0)
    pin_previous_block_count                  = optional(number, 0)
    enhanced_biometrics_state                 = optional(string, "notConfigured")
    security_key_for_sign_in                  = optional(string, "notConfigured")
  })
  default = null
}

################################################################################
# Optional - Assignments
################################################################################

variable "assignments" {
  description = "Configuration assignments to groups."
  type = list(object({
    target_type = string
    group_id    = optional(string)
    filter_id   = optional(string)
    filter_type = optional(string)
  }))
  default = []
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags (for module consistency, not applied to resource)."
  type        = map(string)
  default     = {}
}
