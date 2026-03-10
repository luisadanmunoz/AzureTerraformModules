################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Maintenance Configuration."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Maintenance Configuration should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Maintenance Configuration. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'maint'."
  type        = string
  default     = "maint"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "config"
}

variable "environment" {
  description = "(Optional) Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number for the naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Maintenance Configuration
################################################################################

variable "scope" {
  description = "(Required) The scope of the Maintenance Configuration. Values: Extension, Host, InGuestPatch, OSImage, SQLDB, SQLManagedInstance."
  type        = string

  validation {
    condition     = contains(["Extension", "Host", "InGuestPatch", "OSImage", "SQLDB", "SQLManagedInstance"], var.scope)
    error_message = "scope must be one of: Extension, Host, InGuestPatch, OSImage, SQLDB, SQLManagedInstance."
  }
}

variable "visibility" {
  description = "(Optional) The visibility of the Maintenance Configuration. Values: Custom, Public. Default: Custom."
  type        = string
  default     = "Custom"

  validation {
    condition     = contains(["Custom", "Public"], var.visibility)
    error_message = "visibility must be either 'Custom' or 'Public'."
  }
}

variable "in_guest_user_patch_mode" {
  description = "(Optional) The in-guest user patch mode. Values: Platform, User. Required when scope is InGuestPatch."
  type        = string
  default     = null

  validation {
    condition     = var.in_guest_user_patch_mode == null || contains(["Platform", "User"], var.in_guest_user_patch_mode)
    error_message = "in_guest_user_patch_mode must be either 'Platform' or 'User'."
  }
}

variable "properties" {
  description = "(Optional) A map of properties for the Maintenance Configuration."
  type        = map(string)
  default     = {}
}

################################################################################
# Schedule (Window)
################################################################################

variable "window" {
  description = <<-EOT
    (Optional) Maintenance window configuration.
    - start_date_time: Start date/time in format 'yyyy-MM-dd HH:mm'.
    - expiration_date_time: (Optional) Expiration date/time.
    - duration: Duration in HH:mm format (e.g., '02:00' for 2 hours).
    - time_zone: Time zone (e.g., 'UTC', 'Pacific Standard Time').
    - recur_every: Recurrence pattern (e.g., 'Day', 'Week', '2Weeks', 'Month').
  EOT
  type = object({
    start_date_time      = string
    expiration_date_time = optional(string, null)
    duration             = optional(string, "02:00")
    time_zone            = optional(string, "UTC")
    recur_every          = optional(string, null)
  })
  default = null
}

################################################################################
# Install Patches (for InGuestPatch scope)
################################################################################

variable "install_patches" {
  description = <<-EOT
    (Optional) Install patches configuration for InGuestPatch scope.
    - reboot: Reboot behavior. Values: Always, IfRequired, Never.
    - linux: Linux patch configuration.
    - windows: Windows patch configuration.
  EOT
  type = object({
    reboot = optional(string, "IfRequired")
    linux = optional(object({
      classifications_to_include    = optional(list(string), ["Critical", "Security"])
      package_names_mask_to_exclude = optional(list(string), [])
      package_names_mask_to_include = optional(list(string), [])
    }), null)
    windows = optional(object({
      classifications_to_include = optional(list(string), ["Critical", "Security"])
      kb_numbers_to_exclude      = optional(list(string), [])
      kb_numbers_to_include      = optional(list(string), [])
    }), null)
  })
  default = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
