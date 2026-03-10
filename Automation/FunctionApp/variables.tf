################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Function App."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Function App should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Function App. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'func'."
  type        = string
  default     = "func"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "app"
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
# Function App Configuration
################################################################################

variable "os_type" {
  description = "(Required) The OS type for the Function App. Values: Linux, Windows."
  type        = string

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "os_type must be either 'Linux' or 'Windows'."
  }
}

variable "service_plan_id" {
  description = "(Required) The ID of the App Service Plan. DEPENDENCY: App Service Plan must exist."
  type        = string
}

variable "storage_account_name" {
  description = "(Required) The name of the Storage Account. DEPENDENCY: Storage Account must exist."
  type        = string
}

variable "storage_account_access_key" {
  description = "(Optional) The access key for the Storage Account. Required if storage_uses_managed_identity is false."
  type        = string
  default     = null
  sensitive   = true
}

variable "storage_uses_managed_identity" {
  description = "(Optional) Use Managed Identity to access Storage Account. Default: false."
  type        = bool
  default     = false
}

variable "functions_extension_version" {
  description = "(Optional) The runtime version of the Function App. Default: ~4."
  type        = string
  default     = "~4"
}

variable "builtin_logging_enabled" {
  description = "(Optional) Whether built-in logging is enabled. Default: true."
  type        = bool
  default     = true
}

variable "enabled" {
  description = "(Optional) Whether the Function App is enabled. Default: true."
  type        = bool
  default     = true
}

variable "https_only" {
  description = "(Optional) Whether HTTPS only is enabled. Default: true."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether public network access is enabled. Default: true."
  type        = bool
  default     = true
}

variable "client_certificate_enabled" {
  description = "(Optional) Whether client certificates are enabled. Default: false."
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = "(Optional) Client certificate mode. Values: Required, Optional, OptionalInteractiveUser."
  type        = string
  default     = null
}

################################################################################
# App Settings
################################################################################

variable "app_settings" {
  description = "(Optional) Map of application settings."
  type        = map(string)
  default     = {}
}

################################################################################
# Site Config
################################################################################

variable "site_config" {
  description = <<-EOT
    (Optional) Site configuration block.
    - always_on: Enable always on. Default: false (must be false for Consumption).
    - ftps_state: FTPS state. Default: Disabled.
    - http2_enabled: Enable HTTP2. Default: true.
    - minimum_tls_version: Minimum TLS version. Default: 1.2.
    - application_insights_key: Application Insights key.
    - application_insights_connection_string: App Insights connection string.
    - application_stack: Application stack configuration.
    - cors: CORS configuration.
    - ip_restriction: List of IP restrictions.
  EOT
  type = object({
    always_on                              = optional(bool, false)
    ftps_state                             = optional(string, "Disabled")
    http2_enabled                          = optional(bool, true)
    minimum_tls_version                    = optional(string, "1.2")
    use_32_bit_worker                      = optional(bool, false)
    vnet_route_all_enabled                 = optional(bool, false)
    application_insights_key               = optional(string, null)
    application_insights_connection_string = optional(string, null)
    application_stack = optional(object({
      dotnet_version              = optional(string, null)
      java_version                = optional(string, null)
      node_version                = optional(string, null)
      python_version              = optional(string, null)
      powershell_core_version     = optional(string, null)
      use_dotnet_isolated_runtime = optional(bool, false)
    }), null)
    cors = optional(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool, false)
    }), null)
    ip_restriction = optional(list(object({
      name                      = optional(string, null)
      action                    = optional(string, "Allow")
      ip_address                = optional(string, null)
      virtual_network_subnet_id = optional(string, null)
      service_tag               = optional(string, null)
      priority                  = optional(number, 100)
    })), [])
  })
  default = {}
}

################################################################################
# Virtual Network Integration
################################################################################

variable "virtual_network_subnet_id" {
  description = "(Optional) The ID of the subnet for VNet integration. DEPENDENCY: Subnet must exist."
  type        = string
  default     = null
}

################################################################################
# Identity
################################################################################

variable "identity" {
  description = <<-EOT
    (Optional) Identity configuration.
    - type: Type of identity. Values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned.
    - identity_ids: List of User Assigned Identity IDs.
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null
}

################################################################################
# Connection Strings
################################################################################

variable "connection_strings" {
  description = <<-EOT
    (Optional) List of connection strings.
    - name: Name of the connection string.
    - type: Type (SQLServer, SQLAzure, Custom, etc.).
    - value: Connection string value.
  EOT
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default   = []
  sensitive = true
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
