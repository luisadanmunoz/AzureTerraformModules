################################################################################
# Required Variables
################################################################################

variable "display_name" {
  description = "The display name for the conditional access policy."
  type        = string
}

variable "state" {
  description = "The state of the policy. Possible values: enabled, disabled, enabledForReportingButNotEnforced."
  type        = string
  default     = "disabled"

  validation {
    condition     = contains(["enabled", "disabled", "enabledForReportingButNotEnforced"], var.state)
    error_message = "state must be one of: enabled, disabled, enabledForReportingButNotEnforced."
  }
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the policy."
  type        = bool
  default     = true
}

################################################################################
# Conditions - Users
################################################################################

variable "conditions_users" {
  description = "User conditions for the policy."
  type = object({
    included_users  = optional(list(string), [])
    excluded_users  = optional(list(string), [])
    included_groups = optional(list(string), [])
    excluded_groups = optional(list(string), [])
    included_roles  = optional(list(string), [])
    excluded_roles  = optional(list(string), [])
    included_guests_or_external_users = optional(object({
      guest_or_external_user_types = optional(list(string), [])
      external_tenants = optional(object({
        membership_kind = optional(string)
        members         = optional(list(string), [])
      }))
    }))
    excluded_guests_or_external_users = optional(object({
      guest_or_external_user_types = optional(list(string), [])
      external_tenants = optional(object({
        membership_kind = optional(string)
        members         = optional(list(string), [])
      }))
    }))
  })
  default = {
    included_users = ["All"]
  }
}

################################################################################
# Conditions - Applications
################################################################################

variable "conditions_applications" {
  description = "Application conditions for the policy."
  type = object({
    included_applications = optional(list(string), ["All"])
    excluded_applications = optional(list(string), [])
    included_user_actions = optional(list(string), [])
  })
  default = {
    included_applications = ["All"]
  }
}

################################################################################
# Conditions - Client App Types
################################################################################

variable "conditions_client_app_types" {
  description = "Client app types for the policy. Possible values: all, browser, mobileAppsAndDesktopClients, exchangeActiveSync, other."
  type        = list(string)
  default     = ["all"]
}

################################################################################
# Conditions - Platforms
################################################################################

variable "conditions_platforms" {
  description = "Platform conditions for the policy."
  type = object({
    included_platforms = optional(list(string), [])
    excluded_platforms = optional(list(string), [])
  })
  default = null
}

################################################################################
# Conditions - Locations
################################################################################

variable "conditions_locations" {
  description = "Location conditions for the policy."
  type = object({
    included_locations = optional(list(string), [])
    excluded_locations = optional(list(string), [])
  })
  default = null
}

################################################################################
# Conditions - Sign-in Risk
################################################################################

variable "conditions_sign_in_risk_levels" {
  description = "Sign-in risk levels. Possible values: low, medium, high, hidden, none."
  type        = list(string)
  default     = []
}

variable "conditions_user_risk_levels" {
  description = "User risk levels. Possible values: low, medium, high, hidden, none."
  type        = list(string)
  default     = []
}

################################################################################
# Grant Controls
################################################################################

variable "grant_controls" {
  description = "Grant controls for the policy."
  type = object({
    operator                          = optional(string, "OR")
    built_in_controls                 = optional(list(string), [])
    custom_authentication_factors     = optional(list(string), [])
    terms_of_use                      = optional(list(string), [])
    authentication_strength_policy_id = optional(string)
  })
  default = {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }
}

################################################################################
# Session Controls
################################################################################

variable "session_controls" {
  description = "Session controls for the policy."
  type = object({
    application_enforced_restrictions_enabled = optional(bool)
    cloud_app_security_policy                 = optional(string)
    disable_resilience_defaults               = optional(bool)
    persistent_browser_mode                   = optional(string)
    sign_in_frequency                         = optional(number)
    sign_in_frequency_period                  = optional(string)
    sign_in_frequency_authentication_type     = optional(string)
    sign_in_frequency_interval                = optional(string)
  })
  default = null
}
