################################################################################
# Required Variables
################################################################################

variable "client_id" {
  description = "The client ID (application ID) of the application for which to create a service principal."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the service principal."
  type        = bool
  default     = true
}

################################################################################
# Optional - Service Principal Configuration
################################################################################

variable "account_enabled" {
  description = "Whether the service principal account is enabled."
  type        = bool
  default     = true
}

variable "alternative_names" {
  description = "A set of alternative names used to refer to this service principal."
  type        = set(string)
  default     = []
}

variable "app_role_assignment_required" {
  description = "Whether users or other service principals need an app role assignment before access is granted."
  type        = bool
  default     = false
}

variable "description" {
  description = "A description of the service principal."
  type        = string
  default     = null
}

variable "login_url" {
  description = "The URL where the service provider redirects the user to Azure AD to authenticate."
  type        = string
  default     = null
}

variable "notes" {
  description = "Free text field for notes about the service principal."
  type        = string
  default     = null
}

variable "notification_email_addresses" {
  description = "A set of email addresses for receiving notifications."
  type        = set(string)
  default     = []
}

variable "owners" {
  description = "A set of object IDs of principals that will be granted ownership."
  type        = set(string)
  default     = []
}

variable "preferred_single_sign_on_mode" {
  description = "The single sign-on mode configured for this application. Possible values: oidc, password, saml, notSupported."
  type        = string
  default     = null

  validation {
    condition     = var.preferred_single_sign_on_mode == null || contains(["oidc", "password", "saml", "notSupported"], var.preferred_single_sign_on_mode)
    error_message = "preferred_single_sign_on_mode must be one of: oidc, password, saml, notSupported."
  }
}

variable "use_existing" {
  description = "Whether to use an existing service principal instead of creating a new one."
  type        = bool
  default     = false
}

################################################################################
# Optional - SAML Single Sign-On
################################################################################

variable "saml_single_sign_on" {
  description = "SAML single sign-on configuration."
  type = object({
    relay_state = optional(string)
  })
  default = null
}

################################################################################
# Optional - Feature Tags
################################################################################

variable "feature_tags" {
  description = "Block of features to configure for this service principal using tags."
  type = object({
    custom_single_sign_on = optional(bool, false)
    enterprise            = optional(bool, false)
    gallery               = optional(bool, false)
    hide                  = optional(bool, false)
  })
  default = null
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A set of tags to apply to the service principal."
  type        = set(string)
  default     = []
}
