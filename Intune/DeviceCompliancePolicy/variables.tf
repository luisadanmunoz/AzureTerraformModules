################################################################################
# Required Variables
################################################################################

variable "display_name" {
  description = "The display name of the device compliance policy."
  type        = string
}

variable "platform" {
  description = "The platform for the compliance policy. Possible values are windows10, iOS, android, macOS, androidForWork."
  type        = string

  validation {
    condition     = contains(["windows10", "iOS", "android", "macOS", "androidForWork"], var.platform)
    error_message = "The platform must be one of: windows10, iOS, android, macOS, androidForWork."
  }
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the device compliance policy resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "description" {
  description = "The description of the device compliance policy."
  type        = string
  default     = null
}

################################################################################
# Optional - Windows 10 Compliance Settings
################################################################################

variable "windows_compliance_settings" {
  description = "Windows 10 compliance settings."
  type = object({
    password_required                      = optional(bool, false)
    password_required_type                 = optional(string, "deviceDefault")
    password_minimum_length                = optional(number)
    password_minutes_of_inactivity_before_lock = optional(number)
    password_expiration_days               = optional(number)
    password_previous_password_block_count = optional(number)
    require_healthy_device_report          = optional(bool, false)
    os_minimum_version                     = optional(string)
    os_maximum_version                     = optional(string)
    mobile_os_minimum_version              = optional(string)
    mobile_os_maximum_version              = optional(string)
    early_launch_anti_malware_driver_enabled = optional(bool)
    bit_locker_enabled                     = optional(bool, false)
    secure_boot_enabled                    = optional(bool, false)
    code_integrity_enabled                 = optional(bool, false)
    storage_require_encryption             = optional(bool, false)
    active_firewall_required               = optional(bool, false)
    defender_enabled                       = optional(bool, false)
    defender_version                       = optional(string)
    signature_out_of_date                  = optional(bool)
    rtp_enabled                            = optional(bool)
    antivirus_required                     = optional(bool, false)
    anti_spyware_required                  = optional(bool, false)
    device_threat_protection_enabled       = optional(bool, false)
    device_threat_protection_required_security_level = optional(string)
    configuration_manager_compliance_required = optional(bool, false)
    tpm_required                           = optional(bool, false)
  })
  default = null
}

################################################################################
# Optional - iOS Compliance Settings
################################################################################

variable "ios_compliance_settings" {
  description = "iOS compliance settings."
  type = object({
    passcode_required                      = optional(bool, false)
    passcode_block_simple                  = optional(bool, false)
    passcode_minimum_length                = optional(number)
    passcode_required_type                 = optional(string, "deviceDefault")
    passcode_minutes_of_inactivity_before_lock = optional(number)
    passcode_expiration_days               = optional(number)
    passcode_previous_passcode_block_count = optional(number)
    os_minimum_version                     = optional(string)
    os_maximum_version                     = optional(string)
    os_minimum_build_version               = optional(string)
    os_maximum_build_version               = optional(string)
    security_block_jailbroken_devices      = optional(bool, false)
    device_threat_protection_enabled       = optional(bool, false)
    device_threat_protection_required_security_level = optional(string)
    managed_email_profile_required         = optional(bool, false)
    restricted_apps                        = optional(list(object({
      name       = string
      app_id     = string
      publisher  = optional(string)
    })), [])
  })
  default = null
}

################################################################################
# Optional - Android Compliance Settings
################################################################################

variable "android_compliance_settings" {
  description = "Android compliance settings."
  type = object({
    password_required                      = optional(bool, false)
    password_minimum_length                = optional(number)
    password_required_type                 = optional(string, "deviceDefault")
    password_minutes_of_inactivity_before_lock = optional(number)
    password_expiration_days               = optional(number)
    password_previous_password_block_count = optional(number)
    security_prevent_install_apps_from_unknown_sources = optional(bool, false)
    security_disable_usb_debugging         = optional(bool, false)
    security_require_verify_apps           = optional(bool, false)
    device_threat_protection_enabled       = optional(bool, false)
    device_threat_protection_required_security_level = optional(string)
    security_block_jailbroken_devices      = optional(bool, false)
    os_minimum_version                     = optional(string)
    os_maximum_version                     = optional(string)
    min_android_security_patch_level       = optional(string)
    storage_require_encryption             = optional(bool, false)
    security_require_safety_net_attestation_basic_integrity = optional(bool, false)
    security_require_safety_net_attestation_certified_device = optional(bool, false)
    security_require_google_play_services  = optional(bool, false)
    security_require_up_to_date_security_providers = optional(bool, false)
    security_require_company_portal_app_integrity = optional(bool, false)
    restricted_apps                        = optional(list(object({
      name       = string
      app_id     = string
      publisher  = optional(string)
    })), [])
  })
  default = null
}

################################################################################
# Optional - macOS Compliance Settings
################################################################################

variable "macos_compliance_settings" {
  description = "macOS compliance settings."
  type = object({
    password_required                      = optional(bool, false)
    password_block_simple                  = optional(bool, false)
    password_minimum_length                = optional(number)
    password_required_type                 = optional(string, "deviceDefault")
    password_minutes_of_inactivity_before_lock = optional(number)
    password_expiration_days               = optional(number)
    password_previous_password_block_count = optional(number)
    os_minimum_version                     = optional(string)
    os_maximum_version                     = optional(string)
    os_minimum_build_version               = optional(string)
    os_maximum_build_version               = optional(string)
    system_integrity_protection_enabled    = optional(bool, false)
    device_threat_protection_enabled       = optional(bool, false)
    device_threat_protection_required_security_level = optional(string)
    storage_require_encryption             = optional(bool, false)
    firewall_enabled                       = optional(bool, false)
    firewall_block_all_incoming            = optional(bool, false)
    firewall_enable_stealth_mode           = optional(bool, false)
    gatekeeper_allowed_app_source          = optional(string)
  })
  default = null
}

################################################################################
# Optional - Actions for Non-Compliance
################################################################################

variable "scheduled_actions_for_rule" {
  description = "Scheduled actions for non-compliance."
  type = list(object({
    rule_name = optional(string, "DeviceNonCompliant")
    scheduled_action_configurations = list(object({
      action_type                    = string
      grace_period_hours             = optional(number, 0)
      notification_template_id       = optional(string)
      notification_message_cc_list   = optional(list(string), [])
      notification_additional_recipients = optional(list(string), [])
    }))
  }))
  default = []
}

################################################################################
# Optional - Assignments
################################################################################

variable "assignments" {
  description = "Policy assignments to groups."
  type = list(object({
    target_type      = string
    group_id         = optional(string)
    filter_id        = optional(string)
    filter_type      = optional(string)
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
