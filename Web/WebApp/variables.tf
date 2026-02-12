# -----------------------------------------------------------------------------
# Common Variables
# -----------------------------------------------------------------------------

variable "create" {
  description = "Whether to create the Web App resource"
  type        = bool
  default     = true
}

# DEPENDENCY: Resource Group must exist before creating Web App
variable "resource_group_name" {
  description = "The name of the resource group in which to create the Web App"
  type        = string
}

variable "location" {
  description = "The Azure region where the Web App will be created"
  type        = string
}

variable "name" {
  description = "The name of the Web App. If provided, overrides generated name"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the generated Web App name"
  type        = string
  default     = "app"
}

variable "workload" {
  description = "The workload name for the Web App"
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
  default     = null
}

variable "instance" {
  description = "The instance identifier for the Web App"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

# -----------------------------------------------------------------------------
# Web App Specific Variables
# -----------------------------------------------------------------------------

# DEPENDENCY: App Service Plan must exist before creating Web App
variable "service_plan_id" {
  description = "The ID of the App Service Plan to host the Web App"
  type        = string
}

variable "os_type" {
  description = "The operating system type for the Web App"
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "The os_type must be either 'Linux' or 'Windows'."
  }
}

variable "https_only" {
  description = "Whether the Web App should only accept HTTPS requests"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for the Web App"
  type        = bool
  default     = true
}

# DEPENDENCY: Virtual Network Subnet must exist if VNet integration is required
variable "virtual_network_subnet_id" {
  description = "The ID of the subnet for VNet integration"
  type        = string
  default     = null
}

variable "site_config" {
  description = "The site configuration for the Web App"
  type = object({
    always_on             = optional(bool, true)
    ftps_state            = optional(string, "Disabled")
    http2_enabled         = optional(bool, true)
    minimum_tls_version   = optional(string, "1.2")
    app_command_line      = optional(string)
    health_check_path     = optional(string)
    worker_count          = optional(number)
    application_stack = optional(object({
      # Linux application stack
      docker_image       = optional(string)
      docker_image_tag   = optional(string)
      dotnet_version     = optional(string)
      java_version       = optional(string)
      node_version       = optional(string)
      php_version        = optional(string)
      python_version     = optional(string)
      ruby_version       = optional(string)
      go_version         = optional(string)
      # Windows application stack
      current_stack = optional(string)
    }))
  })
  default = {}
}

variable "app_settings" {
  description = "A map of app settings for the Web App"
  type        = map(string)
  default     = {}
}

variable "connection_strings" {
  description = "A list of connection strings for the Web App"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = []
}

variable "identity" {
  description = "The managed identity configuration for the Web App"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "The identity type must be 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'."
  }
}

variable "auth_settings_v2" {
  description = "The authentication settings v2 for the Web App"
  type = object({
    auth_enabled                            = optional(bool, true)
    runtime_version                         = optional(string, "~1")
    config_file_path                        = optional(string)
    require_authentication                  = optional(bool, true)
    unauthenticated_action                  = optional(string, "RedirectToLoginPage")
    default_provider                        = optional(string)
    excluded_paths                          = optional(list(string))
    require_https                           = optional(bool, true)
    http_route_api_prefix                   = optional(string, "/.auth")
    forward_proxy_convention                = optional(string)
    forward_proxy_custom_host_header_name   = optional(string)
    forward_proxy_custom_scheme_header_name = optional(string)
    login = optional(object({
      logout_endpoint                   = optional(string)
      token_store_enabled               = optional(bool)
      token_refresh_extension_time      = optional(number)
      token_store_path                  = optional(string)
      token_store_sas_setting_name      = optional(string)
      preserve_url_fragments_for_logins = optional(bool)
      allowed_external_redirect_urls    = optional(list(string))
      cookie_expiration_convention      = optional(string)
      cookie_expiration_time            = optional(string)
      validate_nonce                    = optional(bool)
      nonce_expiration_time             = optional(string)
    }))
    active_directory_v2 = optional(object({
      client_id                            = string
      tenant_auth_endpoint                 = optional(string)
      client_secret_setting_name           = optional(string)
      client_secret_certificate_thumbprint = optional(string)
      jwt_allowed_groups                   = optional(list(string))
      jwt_allowed_client_applications      = optional(list(string))
      www_authentication_disabled          = optional(bool)
      allowed_groups                       = optional(list(string))
      allowed_identities                   = optional(list(string))
      allowed_applications                 = optional(list(string))
      login_parameters                     = optional(map(string))
      allowed_audiences                    = optional(list(string))
    }))
    azure_static_web_app_v2 = optional(object({
      client_id = string
    }))
    custom_oidc_v2 = optional(list(object({
      name                          = string
      client_id                     = string
      openid_configuration_endpoint = string
      name_claim_type               = optional(string)
      scopes                        = optional(list(string))
      client_credential_method      = optional(string)
      client_secret_setting_name    = optional(string)
      authorisation_endpoint        = optional(string)
      token_endpoint                = optional(string)
      issuer_endpoint               = optional(string)
      certification_uri             = optional(string)
    })))
    facebook_v2 = optional(object({
      app_id                  = string
      app_secret_setting_name = string
      graph_api_version       = optional(string)
      login_scopes            = optional(list(string))
    }))
    github_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      login_scopes               = optional(list(string))
    }))
    google_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    }))
    microsoft_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    }))
    twitter_v2 = optional(object({
      consumer_key                 = string
      consumer_secret_setting_name = string
    }))
    apple_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
    }))
  })
  default = null
}

variable "sticky_settings" {
  description = "The sticky settings for deployment slots"
  type = object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  })
  default = null
}

variable "backup" {
  description = "The backup configuration for the Web App"
  type = object({
    name                = string
    storage_account_url = string
    enabled             = optional(bool, true)
    schedule = object({
      frequency_interval       = number
      frequency_unit           = string
      retention_period_days    = optional(number, 30)
      start_time               = optional(string)
      keep_at_least_one_backup = optional(bool, true)
    })
  })
  default = null
}

variable "logs" {
  description = "The logging configuration for the Web App"
  type = object({
    detailed_error_messages = optional(bool, false)
    failed_request_tracing  = optional(bool, false)
    http_logs = optional(object({
      azure_blob_storage = optional(object({
        sas_url           = string
        retention_in_days = optional(number, 7)
      }))
      file_system = optional(object({
        retention_in_days = optional(number, 7)
        retention_in_mb   = optional(number, 35)
      }))
    }))
    application_logs = optional(object({
      file_system_level = optional(string, "Warning")
      azure_blob_storage = optional(object({
        level             = string
        sas_url           = string
        retention_in_days = optional(number, 7)
      }))
    }))
  })
  default = null
}

variable "storage_account" {
  description = "The storage account configuration for mounted storage"
  type = list(object({
    name         = string
    type         = string
    account_name = string
    share_name   = string
    access_key   = string
    mount_path   = optional(string)
  }))
  default = []
}
