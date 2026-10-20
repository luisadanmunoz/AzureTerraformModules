################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Logic App Standard."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Logic App should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Logic App Standard. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'logic'."
  type        = string
  default     = "logic"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "std"
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
# App Service Plan
################################################################################

variable "app_service_plan_id" {
  description = "(Required) The ID of the App Service Plan. DEPENDENCY: Must be WS1, WS2, or WS3 SKU for Logic Apps Standard."
  type        = string
}

################################################################################
# Storage Account
################################################################################

variable "storage_account_name" {
  description = "(Required) The name of the Storage Account for the Logic App. DEPENDENCY: Storage Account must exist."
  type        = string
}

variable "storage_account_access_key" {
  description = "(Required) The access key for the Storage Account."
  type        = string
  sensitive   = true
}

variable "storage_account_share_name" {
  description = "(Optional) The name of the File Share in the Storage Account."
  type        = string
  default     = null
}

################################################################################
# Logic App Configuration
################################################################################

variable "enabled" {
  description = "(Optional) Whether the Logic App is enabled. Default: true."
  type        = bool
  default     = true
}

variable "version" {
  description = "(Optional) The runtime version for the Logic App. Default: ~4."
  type        = string
  default     = "~4"
}

variable "use_extension_bundle" {
  description = "(Optional) Whether to use extension bundle. Default: true."
  type        = bool
  default     = true
}

variable "bundle_version" {
  description = "(Optional) The version range for extension bundle. Default: [1.*, 2.0.0)."
  type        = string
  default     = "[1.*, 2.0.0)"
}

variable "https_only" {
  description = "(Optional) Whether HTTPS only is enabled. Default: true."
  type        = bool
  default     = true
}

variable "client_affinity_enabled" {
  description = "(Optional) Whether client affinity is enabled. Default: false."
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = "(Optional) Client certificate mode. Values: Required, Optional, OptionalInteractiveUser."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether public network access is enabled. Default: true."
  type        = bool
  default     = true
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
    - always_on: (Optional) Whether always on is enabled. Default: false.
    - app_scale_limit: (Optional) Maximum number of workers.
    - ftps_state: (Optional) FTPS state. Values: AllAllowed, FtpsOnly, Disabled.
    - health_check_path: (Optional) Health check path.
    - http2_enabled: (Optional) Whether HTTP2 is enabled.
    - minimum_tls_version: (Optional) Minimum TLS version. Default: 1.2.
    - pre_warmed_instance_count: (Optional) Pre-warmed instances.
    - runtime_scale_monitoring_enabled: (Optional) Enable runtime scale monitoring.
    - use_32_bit_worker: (Optional) Use 32-bit worker. Default: true.
    - vnet_route_all_enabled: (Optional) Route all traffic through VNet.
    - websockets_enabled: (Optional) Enable WebSockets.
    - elastic_instance_minimum: (Optional) Minimum elastic instances.
    - ip_restriction: (Optional) List of IP restrictions.
    - scm_ip_restriction: (Optional) List of SCM IP restrictions.
  EOT
  type = object({
    always_on                      = optional(bool, false)
    app_scale_limit                = optional(number, null)
    ftps_state                     = optional(string, "Disabled")
    health_check_path              = optional(string, null)
    http2_enabled                  = optional(bool, true)
    minimum_tls_version            = optional(string, "1.2")
    pre_warmed_instance_count      = optional(number, null)
    runtime_scale_monitoring_enabled = optional(bool, false)
    use_32_bit_worker              = optional(bool, false)
    vnet_route_all_enabled         = optional(bool, false)
    websockets_enabled             = optional(bool, false)
    elastic_instance_minimum       = optional(number, null)
    dotnet_framework_version       = optional(string, "v6.0")
    ip_restriction = optional(list(object({
      name                      = optional(string, null)
      action                    = optional(string, "Allow")
      ip_address                = optional(string, null)
      virtual_network_subnet_id = optional(string, null)
      service_tag               = optional(string, null)
      priority                  = optional(number, 100)
    })), [])
    scm_ip_restriction = optional(list(object({
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
    - type: (Required) Type of identity. Values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned.
    - identity_ids: (Optional) List of User Assigned Identity IDs.
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
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
