################################################################################
# Required Variables
################################################################################

variable "display_name" {
  description = "The display name of the Windows Autopilot deployment profile."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Windows Autopilot deployment profile resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "description" {
  description = "The description of the Windows Autopilot deployment profile."
  type        = string
  default     = null
}

variable "device_name_template" {
  description = "The template for the device name. Use %SERIAL% for serial number."
  type        = string
  default     = null
}

variable "device_type" {
  description = "The type of Windows Autopilot profile. Possible values are windowsPc, surfaceHub2."
  type        = string
  default     = "windowsPc"

  validation {
    condition     = contains(["windowsPc", "surfaceHub2", "holoLens"], var.device_type)
    error_message = "The device_type must be one of: windowsPc, surfaceHub2, holoLens."
  }
}

variable "enable_white_glove" {
  description = "Whether to enable white glove (pre-provisioning) mode."
  type        = bool
  default     = false
}

variable "enrollment_status_page_timeout_in_minutes" {
  description = "Timeout in minutes for the enrollment status page."
  type        = number
  default     = 60
}

################################################################################
# Optional - Out-of-Box Experience (OOBE) Settings
################################################################################

variable "oobe_settings" {
  description = "Out-of-Box Experience (OOBE) settings."
  type = object({
    hide_eula                           = optional(bool, true)
    hide_privacy_settings               = optional(bool, true)
    hide_change_account_options         = optional(bool, true)
    user_type                           = optional(string, "standard")
    device_usage_type                   = optional(string, "singleUser")
    skip_keyboard_selection_page        = optional(bool, true)
    hide_escape_link                    = optional(bool, true)
  })
  default = {}
}

################################################################################
# Optional - Enrollment Status Page Settings
################################################################################

variable "enrollment_status_page" {
  description = "Enrollment Status Page (ESP) settings."
  type = object({
    show_progress                           = optional(bool, true)
    block_device_use_until_profile_complete = optional(bool, true)
    allow_device_use_on_error               = optional(bool, false)
    allow_log_collection_on_error           = optional(bool, true)
    allow_device_reset_on_error             = optional(bool, false)
    allow_retry                             = optional(bool, true)
    custom_error_message                    = optional(string)
    show_installation_progress              = optional(bool, true)
    install_progress_timeout_in_minutes     = optional(number, 60)
    selected_mobile_app_ids                 = optional(list(string), [])
    track_install_progress_for_autpilot_only = optional(bool, true)
    disable_user_status_tracking_after_first_user = optional(bool, false)
  })
  default = {}
}

################################################################################
# Optional - Hybrid Azure AD Join Settings
################################################################################

variable "hybrid_azure_ad_join" {
  description = "Hybrid Azure AD Join settings."
  type = object({
    enabled                = optional(bool, false)
    domain_join_connector = optional(string)
    ou_path               = optional(string)
  })
  default = {}
}

################################################################################
# Optional - Language and Region
################################################################################

variable "language" {
  description = "The language to use during OOBE (e.g., 'en-US', 'es-ES')."
  type        = string
  default     = null
}

variable "keyboard_identifier" {
  description = "The keyboard layout identifier."
  type        = string
  default     = null
}

################################################################################
# Optional - Assignments
################################################################################

variable "assignments" {
  description = "Profile assignments to groups."
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
