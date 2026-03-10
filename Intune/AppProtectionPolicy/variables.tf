################################################################################
# Required Variables
################################################################################

variable "display_name" {
  description = "The display name of the app protection policy."
  type        = string
}

variable "platform" {
  description = "The platform for the app protection policy. Possible values are iOS, android."
  type        = string

  validation {
    condition     = contains(["iOS", "android"], var.platform)
    error_message = "The platform must be one of: iOS, android."
  }
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the app protection policy resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "description" {
  description = "The description of the app protection policy."
  type        = string
  default     = null
}

################################################################################
# Optional - Data Protection Settings
################################################################################

variable "data_protection" {
  description = "Data protection settings."
  type = object({
    # Data transfer
    allow_backup                         = optional(bool, true)
    allow_save_to_other_apps             = optional(string, "allApps")
    receive_data_from_other_apps         = optional(string, "allApps")
    send_org_data_to_other_apps          = optional(string, "allApps")
    prevent_backup                       = optional(bool, false)
    disable_app_encryption_if_device_encryption_is_enabled = optional(bool, false)

    # Cut, copy, paste
    restrict_cut_copy_paste              = optional(string, "allApps")
    cut_copy_paste_blocked               = optional(bool, false)

    # Printing
    printing_blocked                     = optional(bool, false)
    print_org_data                       = optional(string, "allowed")

    # Data storage
    save_as_blocked                      = optional(bool, false)
    contact_sync_blocked                 = optional(bool, false)
    data_backup_blocked                  = optional(bool, false)
    device_compliance_required           = optional(bool, false)
    managed_browser_to_open_links_required = optional(bool, false)

    # Encryption
    encrypt_app_data                     = optional(bool, true)
    organizational_credentials_required  = optional(bool, false)

    # Screen capture (Android only)
    screen_capture_blocked               = optional(bool, false)

    # Third party keyboards (iOS only)
    third_party_keyboards_blocked        = optional(bool, false)

    # Face ID (iOS only)
    face_id_blocked                      = optional(bool, false)
  })
  default = {}
}

################################################################################
# Optional - Access Requirements
################################################################################

variable "access_requirements" {
  description = "Access requirements settings."
  type = object({
    # PIN settings
    pin_required                          = optional(bool, true)
    pin_type                              = optional(string, "numeric")
    simple_pin_blocked                    = optional(bool, false)
    minimum_pin_length                    = optional(number, 4)
    pin_character_set                     = optional(string, "numeric")
    pin_maximum_retry_count               = optional(number, 5)
    fingerprint_blocked                   = optional(bool, false)
    disable_pin_after_retry               = optional(bool, false)

    # Period settings
    period_before_pin_reset               = optional(string, "PT0S")
    period_offline_before_access_check    = optional(string, "PT720M")
    period_offline_before_wipe            = optional(string, "P90D")
    period_online_before_access_check     = optional(string, "PT30M")

    # Block after settings
    allowed_inbound_data_transfer_sources = optional(string, "allApps")
    allowed_outbound_clipboard_sharing_level = optional(string, "allApps")
    allowed_outbound_data_transfer_destinations = optional(string, "allApps")

    # Biometric
    biometric_authentication_blocked      = optional(bool, false)
    touch_id_blocked                      = optional(bool, false)
  })
  default = {}
}

################################################################################
# Optional - Conditional Launch
################################################################################

variable "conditional_launch" {
  description = "Conditional launch settings."
  type = object({
    # App conditions
    max_pin_retry_count                   = optional(number)
    offline_grace_period_block            = optional(string)
    offline_grace_period_wipe             = optional(string)
    min_app_version                       = optional(string)
    max_app_version                       = optional(string)
    min_sdk_version                       = optional(string)

    # Device conditions
    min_os_version                        = optional(string)
    max_os_version                        = optional(string)
    jailbroken_device_blocked             = optional(bool, true)
    rooted_device_blocked                 = optional(bool, true)
    device_threat_level                   = optional(string)
    max_allowed_device_threat_level       = optional(string)
    disabled_account                      = optional(string, "block")
  })
  default = {}
}

################################################################################
# Optional - Apps
################################################################################

variable "apps" {
  description = "List of apps to target with this policy."
  type = list(object({
    app_id    = string
    name      = optional(string)
    publisher = optional(string)
  }))
  default = []
}

################################################################################
# Optional - Exempted Apps
################################################################################

variable "exempted_apps" {
  description = "List of apps exempted from this policy."
  type = list(object({
    app_id    = string
    name      = optional(string)
    publisher = optional(string)
  }))
  default = []
}

################################################################################
# Optional - Assignments
################################################################################

variable "assignments" {
  description = "Policy assignments to groups."
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
