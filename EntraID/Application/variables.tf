################################################################################
# Required Variables
################################################################################

variable "display_name" {
  description = "The display name for the application."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the application."
  type        = bool
  default     = true
}

################################################################################
# Optional - Application Configuration
################################################################################

variable "description" {
  description = "A description of the application, as shown to end users."
  type        = string
  default     = null
}

variable "sign_in_audience" {
  description = "The Microsoft account types that are supported for the application. Possible values are: AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount, PersonalMicrosoftAccount."
  type        = string
  default     = "AzureADMyOrg"

  validation {
    condition     = contains(["AzureADMyOrg", "AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount", "PersonalMicrosoftAccount"], var.sign_in_audience)
    error_message = "sign_in_audience must be one of: AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount, PersonalMicrosoftAccount."
  }
}

variable "identifier_uris" {
  description = "A list of user-defined URIs that uniquely identify the application within its Azure AD tenant."
  type        = list(string)
  default     = []
}

variable "owners" {
  description = "A list of object IDs of principals that will be granted ownership of the application."
  type        = list(string)
  default     = []
}

variable "prevent_duplicate_names" {
  description = "If true, will return an error if an existing application is found with the same name."
  type        = bool
  default     = true
}

variable "fallback_public_client_enabled" {
  description = "Specifies whether the application is a public client. Appropriate for apps using token grant flows that don't use a redirect URI."
  type        = bool
  default     = false
}

variable "device_only_auth_enabled" {
  description = "Specifies whether this application supports device authentication without a user."
  type        = bool
  default     = false
}

variable "oauth2_post_response_required" {
  description = "Specifies whether, as part of OAuth 2.0 token requests, Azure AD allows POST requests, as opposed to GET requests."
  type        = bool
  default     = false
}

variable "group_membership_claims" {
  description = "Configures the groups claim issued in tokens. Possible values are: None, SecurityGroup, DirectoryRole, ApplicationGroup, All."
  type        = list(string)
  default     = []
}

variable "logo_image" {
  description = "A logo image to upload for the application, as a raw base64-encoded string."
  type        = string
  default     = null
}

variable "marketing_url" {
  description = "URL of the application's marketing page."
  type        = string
  default     = null
}

variable "privacy_statement_url" {
  description = "URL of the application's privacy statement."
  type        = string
  default     = null
}

variable "support_url" {
  description = "URL of the application's support page."
  type        = string
  default     = null
}

variable "terms_of_service_url" {
  description = "URL of the application's terms of service statement."
  type        = string
  default     = null
}

variable "notes" {
  description = "User-specified notes relevant for the management of the application."
  type        = string
  default     = null
}

variable "service_management_reference" {
  description = "References application context information from a Service or Asset Management database."
  type        = string
  default     = null
}

################################################################################
# Optional - Web Configuration
################################################################################

variable "web" {
  description = "Web configuration for the application including redirect URIs and implicit grant settings."
  type = object({
    homepage_url  = optional(string)
    logout_url    = optional(string)
    redirect_uris = optional(list(string), [])
    implicit_grant = optional(object({
      access_token_issuance_enabled = optional(bool, false)
      id_token_issuance_enabled     = optional(bool, false)
    }))
  })
  default = null
}

################################################################################
# Optional - Single Page Application Configuration
################################################################################

variable "single_page_application" {
  description = "Single-page application configuration including redirect URIs."
  type = object({
    redirect_uris = optional(list(string), [])
  })
  default = null
}

################################################################################
# Optional - Public Client Configuration
################################################################################

variable "public_client" {
  description = "Public client (mobile & desktop) configuration including redirect URIs."
  type = object({
    redirect_uris = optional(list(string), [])
  })
  default = null
}

################################################################################
# Optional - API Configuration
################################################################################

variable "api" {
  description = "API configuration for the application."
  type = object({
    mapped_claims_enabled          = optional(bool, false)
    requested_access_token_version = optional(number, 2)
    known_client_applications      = optional(list(string), [])
    oauth2_permission_scope = optional(list(object({
      id                         = string
      admin_consent_description  = string
      admin_consent_display_name = string
      enabled                    = optional(bool, true)
      type                       = optional(string, "User")
      user_consent_description   = optional(string)
      user_consent_display_name  = optional(string)
      value                      = string
    })), [])
  })
  default = null
}

################################################################################
# Optional - App Roles
################################################################################

variable "app_roles" {
  description = "A collection of app roles that the application may declare."
  type = list(object({
    id                   = string
    allowed_member_types = list(string)
    description          = string
    display_name         = string
    enabled              = optional(bool, true)
    value                = optional(string)
  }))
  default = []
}

################################################################################
# Optional - Required Resource Access
################################################################################

variable "required_resource_access" {
  description = "A collection of required resource access for the application (API permissions)."
  type = list(object({
    resource_app_id = string
    resource_access = list(object({
      id   = string
      type = string
    }))
  }))
  default = []
}

################################################################################
# Optional - Optional Claims
################################################################################

variable "optional_claims" {
  description = "Optional claims configuration for ID tokens, access tokens, and SAML2 tokens."
  type = object({
    access_token = optional(list(object({
      name                  = string
      additional_properties = optional(list(string), [])
      essential             = optional(bool, false)
      source                = optional(string)
    })), [])
    id_token = optional(list(object({
      name                  = string
      additional_properties = optional(list(string), [])
      essential             = optional(bool, false)
      source                = optional(string)
    })), [])
    saml2_token = optional(list(object({
      name                  = string
      additional_properties = optional(list(string), [])
      essential             = optional(bool, false)
      source                = optional(string)
    })), [])
  })
  default = null
}

################################################################################
# Optional - Feature Tags
################################################################################

variable "feature_tags" {
  description = "Block of features to configure for this application using tags."
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
  description = "A set of tags to apply to the application."
  type        = set(string)
  default     = []
}
