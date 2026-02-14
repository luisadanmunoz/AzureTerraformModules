################################################################################
# Required Variables
################################################################################

variable "resource_group_name" {
  description = "The name of the resource group where the Container Registry will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Container Registry will be created."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the Container Registry. If not provided, will be generated from naming variables. Must be globally unique, alphanumeric only."
  type        = string
  default     = null

  validation {
    condition     = var.name == null || can(regex("^[a-zA-Z0-9]{5,50}$", var.name))
    error_message = "Container Registry name must be alphanumeric, between 5 and 50 characters."
  }
}

variable "name_prefix" {
  description = "Prefix for the Container Registry name (alphanumeric only)."
  type        = string
  default     = "cr"
}

variable "workload" {
  description = "The workload name for naming convention (alphanumeric only)."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment name (dev, staging, prod) for naming convention."
  type        = string
  default     = ""
}

variable "instance" {
  description = "The instance identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "sku" {
  description = "The SKU name of the Container Registry. Possible values are Basic, Standard, and Premium."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be Basic, Standard, or Premium."
  }
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled. Disabled by default for security."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for the Container Registry."
  type        = bool
  default     = true
}

variable "quarantine_policy_enabled" {
  description = "Whether quarantine policy is enabled. Only available for Premium SKU."
  type        = bool
  default     = false
}

variable "zone_redundancy_enabled" {
  description = "Whether zone redundancy is enabled. Only available for Premium SKU."
  type        = bool
  default     = false
}

variable "export_policy_enabled" {
  description = "Whether export policy is enabled. Only available for Premium SKU when public access is disabled."
  type        = bool
  default     = true
}

variable "anonymous_pull_enabled" {
  description = "Whether allows anonymous (unauthenticated) pull access to the registry."
  type        = bool
  default     = false
}

variable "data_endpoint_enabled" {
  description = "Whether to enable dedicated data endpoints for the Container Registry. Only available for Premium SKU."
  type        = bool
  default     = false
}

variable "network_rule_bypass_option" {
  description = "Whether to allow trusted Azure services to access the Container Registry. Values are None or AzureServices."
  type        = string
  default     = "AzureServices"

  validation {
    condition     = contains(["None", "AzureServices"], var.network_rule_bypass_option)
    error_message = "Network rule bypass option must be None or AzureServices."
  }
}

################################################################################
# Optional Variables - Geo-replication (Premium only)
################################################################################

variable "georeplications" {
  description = "List of geo-replications for the Container Registry. Only available for Premium SKU."
  type = list(object({
    location                  = string
    regional_endpoint_enabled = optional(bool, false)
    zone_redundancy_enabled   = optional(bool, false)
    tags                      = optional(map(string), {})
  }))
  default = []
}

################################################################################
# Optional Variables - Network Rules (Premium only)
################################################################################

variable "network_rule_set" {
  description = "Network rule set for the Container Registry. Only available for Premium SKU."
  type = object({
    default_action = optional(string, "Deny")
    ip_rules = optional(list(object({
      action   = optional(string, "Allow")
      ip_range = string
    })), [])
    virtual_network_rules = optional(list(object({
      action    = optional(string, "Allow")
      subnet_id = string
    })), [])
  })
  default = null
}

################################################################################
# Optional Variables - Retention Policy (Premium only)
################################################################################

variable "retention_policy" {
  description = "Retention policy for untagged manifests. Only available for Premium SKU."
  type = object({
    days    = optional(number, 7)
    enabled = optional(bool, true)
  })
  default = null
}

################################################################################
# Optional Variables - Trust Policy (Premium only)
################################################################################

variable "trust_policy" {
  description = "Content trust policy for the Container Registry. Only available for Premium SKU."
  type = object({
    enabled = optional(bool, true)
  })
  default = null
}

################################################################################
# Optional Variables - Encryption (Premium only)
################################################################################

variable "encryption" {
  description = "Customer managed key encryption configuration. Only available for Premium SKU."
  type = object({
    enabled            = optional(bool, true)
    key_vault_key_id   = string
    identity_client_id = string
  })
  default = null
}

################################################################################
# Optional Variables - Identity
################################################################################

variable "identity" {
  description = "Managed identity configuration for the Container Registry."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "Identity type must be SystemAssigned, UserAssigned, or 'SystemAssigned, UserAssigned'."
  }
}

################################################################################
# Optional Variables - Webhooks
################################################################################

variable "webhooks" {
  description = "List of webhooks to create for the Container Registry."
  type = list(object({
    name        = string
    service_uri = string
    status      = optional(string, "enabled")
    scope       = optional(string, "")
    actions     = optional(list(string), ["push"])
    custom_headers = optional(map(string), {})
  }))
  default = []
}

################################################################################
# Optional Variables - Scope Maps and Tokens
################################################################################

variable "scope_maps" {
  description = "List of scope maps to create for the Container Registry."
  type = list(object({
    name        = string
    description = optional(string)
    actions     = list(string)
  }))
  default = []
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
