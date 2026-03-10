################################################################################
# Required Variables
################################################################################

variable "display_name" {
  description = "The display name of the mobile app."
  type        = string
}

variable "app_type" {
  description = "The type of app. Possible values are microsoftStoreForBusiness, webLink, windowsMsi, windowsUniversalAppX, iosStoreApp, androidStoreApp, managedIOSStoreApp, managedAndroidStoreApp, win32LobApp."
  type        = string

  validation {
    condition = contains([
      "microsoftStoreForBusiness",
      "webLink",
      "windowsMsi",
      "windowsUniversalAppX",
      "iosStoreApp",
      "androidStoreApp",
      "managedIOSStoreApp",
      "managedAndroidStoreApp",
      "win32LobApp"
    ], var.app_type)
    error_message = "Invalid app_type. Must be one of the supported app types."
  }
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the mobile app resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - Basic Configuration
################################################################################

variable "description" {
  description = "The description of the mobile app."
  type        = string
  default     = null
}

variable "publisher" {
  description = "The publisher of the mobile app."
  type        = string
  default     = null
}

variable "large_icon" {
  description = "The large icon for the app (base64 encoded)."
  type = object({
    type  = string
    value = string
  })
  default = null
}

variable "is_featured" {
  description = "Whether the app is featured in the Company Portal."
  type        = bool
  default     = false
}

variable "privacy_information_url" {
  description = "The privacy information URL."
  type        = string
  default     = null
}

variable "information_url" {
  description = "The information URL."
  type        = string
  default     = null
}

variable "owner" {
  description = "The owner of the app."
  type        = string
  default     = null
}

variable "developer" {
  description = "The developer of the app."
  type        = string
  default     = null
}

variable "notes" {
  description = "Notes for the app."
  type        = string
  default     = null
}

################################################################################
# Optional - iOS Store App Configuration
################################################################################

variable "ios_store_app" {
  description = "iOS Store App configuration."
  type = object({
    app_store_url          = string
    bundle_id              = optional(string)
    applicable_device_type = optional(object({
      ipad        = optional(bool, true)
      iphone_and_ipod = optional(bool, true)
    }))
    minimum_supported_operating_system = optional(object({
      v11_0 = optional(bool, false)
      v12_0 = optional(bool, false)
      v13_0 = optional(bool, false)
      v14_0 = optional(bool, false)
      v15_0 = optional(bool, true)
      v16_0 = optional(bool, false)
    }))
  })
  default = null
}

################################################################################
# Optional - Android Store App Configuration
################################################################################

variable "android_store_app" {
  description = "Android Store App configuration."
  type = object({
    app_store_url = string
    package_id    = optional(string)
    minimum_supported_operating_system = optional(object({
      v5_0  = optional(bool, false)
      v5_1  = optional(bool, false)
      v6_0  = optional(bool, false)
      v7_0  = optional(bool, false)
      v7_1  = optional(bool, false)
      v8_0  = optional(bool, false)
      v8_1  = optional(bool, false)
      v9_0  = optional(bool, false)
      v10_0 = optional(bool, false)
      v11_0 = optional(bool, true)
    }))
  })
  default = null
}

################################################################################
# Optional - Web Link App Configuration
################################################################################

variable "web_link_app" {
  description = "Web Link App configuration."
  type = object({
    app_url     = string
    use_managed_browser = optional(bool, false)
  })
  default = null
}

################################################################################
# Optional - Win32 LOB App Configuration
################################################################################

variable "win32_lob_app" {
  description = "Win32 LOB App configuration."
  type = object({
    file_name                    = string
    install_command_line         = string
    uninstall_command_line       = string
    install_experience_type      = optional(string, "system")
    device_restart_behavior      = optional(string, "allow")
    return_codes                 = optional(list(object({
      return_code = number
      type        = string
    })), [])
    msi_information = optional(object({
      product_code    = string
      product_version = optional(string)
      upgrade_code    = optional(string)
      requires_reboot = optional(bool, false)
      package_type    = optional(string, "perMachine")
    }))
    detection_rules = optional(list(object({
      type                       = string
      path                       = optional(string)
      file_or_folder_name        = optional(string)
      detection_type             = optional(string)
      check_32_bit_on_64_system  = optional(bool, false)
      operator                   = optional(string)
      detection_value            = optional(string)
      registry_key_path          = optional(string)
      registry_value_name        = optional(string)
      script_content             = optional(string)
      enforce_signature_check    = optional(bool, false)
      run_as_32_bit              = optional(bool, false)
    })), [])
    requirement_rules = optional(list(object({
      type                           = string
      operator                       = optional(string)
      detection_value                = optional(string)
      minimum_supported_os_version   = optional(string)
      maximum_supported_os_version   = optional(string)
      disk_space_required_in_mb      = optional(number)
      physical_memory_required_in_mb = optional(number)
      cpu_speed_required_in_mhz      = optional(number)
    })), [])
    minimum_supported_operating_system = optional(object({
      v10_1607 = optional(bool, false)
      v10_1703 = optional(bool, false)
      v10_1709 = optional(bool, false)
      v10_1803 = optional(bool, false)
      v10_1809 = optional(bool, false)
      v10_1903 = optional(bool, false)
      v10_1909 = optional(bool, false)
      v10_2004 = optional(bool, false)
      v10_2h20 = optional(bool, false)
      v10_21h1 = optional(bool, true)
    }))
  })
  default = null
}

################################################################################
# Optional - Assignments
################################################################################

variable "assignments" {
  description = "App assignments to groups."
  type = list(object({
    intent      = string
    target_type = string
    group_id    = optional(string)
    filter_id   = optional(string)
    filter_type = optional(string)
    settings    = optional(object({
      notifications                   = optional(string, "showAll")
      restart_settings                = optional(object({
        grace_period_in_minutes        = optional(number)
        countdown_display_before_restart_in_minutes = optional(number)
        restart_notification_snooze_duration_in_minutes = optional(number)
      }))
      install_time_settings = optional(object({
        use_local_time       = optional(bool, true)
        deadline_date_time   = optional(string)
        start_date_time      = optional(string)
      }))
    }))
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
