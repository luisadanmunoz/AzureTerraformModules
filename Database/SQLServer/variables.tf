################################################################################
# Required Variables
################################################################################

variable "resource_group_name" {
  description = "The name of the resource group where the SQL Server will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the SQL Server will be created."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the SQL Server. If not provided, will be generated from naming variables. Must be globally unique."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the SQL Server name."
  type        = string
  default     = "sql"
}

variable "workload" {
  description = "The workload name for naming convention."
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

variable "version" {
  description = "The version of the SQL Server. Valid values are 2.0 (for v11 server) and 12.0 (for v12 server)."
  type        = string
  default     = "12.0"

  validation {
    condition     = contains(["2.0", "12.0"], var.version)
    error_message = "Version must be 2.0 or 12.0."
  }
}

variable "connection_policy" {
  description = "The connection policy for the SQL Server. Valid values are Default, Proxy, or Redirect."
  type        = string
  default     = "Default"

  validation {
    condition     = contains(["Default", "Proxy", "Redirect"], var.connection_policy)
    error_message = "Connection policy must be Default, Proxy, or Redirect."
  }
}

variable "minimum_tls_version" {
  description = "The minimum TLS version for the SQL Server. Valid values are 1.0, 1.1, 1.2, and Disabled."
  type        = string
  default     = "1.2"

  validation {
    condition     = contains(["1.0", "1.1", "1.2", "Disabled"], var.minimum_tls_version)
    error_message = "Minimum TLS version must be 1.0, 1.1, 1.2, or Disabled."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for the SQL Server."
  type        = bool
  default     = false
}

variable "outbound_network_restriction_enabled" {
  description = "Whether outbound network traffic is restricted for the SQL Server."
  type        = bool
  default     = false
}

################################################################################
# Optional Variables - Authentication
################################################################################

variable "administrator_login" {
  description = "The administrator login name for the SQL Server. Required if azuread_authentication_only is false."
  type        = string
  default     = null
}

variable "administrator_login_password" {
  description = "The administrator login password for the SQL Server. Required if azuread_authentication_only is false."
  type        = string
  default     = null
  sensitive   = true
}

variable "azuread_administrator" {
  description = "Azure AD administrator configuration for the SQL Server."
  type = object({
    login_username              = string
    object_id                   = string
    tenant_id                   = optional(string)
    azuread_authentication_only = optional(bool, false)
  })
  default = null
}

################################################################################
# Optional Variables - Identity
################################################################################

variable "identity" {
  description = "Managed identity configuration for the SQL Server."
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

variable "primary_user_assigned_identity_id" {
  description = "The ID of the primary user assigned identity for the SQL Server."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Firewall Rules
################################################################################

variable "firewall_rules" {
  description = "List of firewall rules to create for the SQL Server."
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}

variable "allow_azure_services" {
  description = "Allow Azure services and resources to access this server."
  type        = bool
  default     = false
}

################################################################################
# Optional Variables - Virtual Network Rules
################################################################################

variable "virtual_network_rules" {
  description = "List of virtual network rules for the SQL Server."
  type = list(object({
    name                                 = string
    subnet_id                            = string
    ignore_missing_vnet_service_endpoint = optional(bool, false)
  }))
  default = []
}

################################################################################
# Optional Variables - Auditing
################################################################################

variable "extended_auditing_policy" {
  description = "Extended auditing policy configuration for the SQL Server."
  type = object({
    enabled                                 = optional(bool, true)
    storage_endpoint                        = optional(string)
    storage_account_access_key              = optional(string)
    storage_account_access_key_is_secondary = optional(bool, false)
    retention_in_days                       = optional(number, 90)
    log_monitoring_enabled                  = optional(bool, true)
  })
  default = null
}

################################################################################
# Optional Variables - Vulnerability Assessment
################################################################################

variable "security_alert_policy" {
  description = "Security alert policy configuration for the SQL Server."
  type = object({
    state                      = optional(string, "Enabled")
    disabled_alerts            = optional(list(string), [])
    email_account_admins       = optional(bool, true)
    email_addresses            = optional(list(string), [])
    retention_days             = optional(number, 30)
    storage_endpoint           = optional(string)
    storage_account_access_key = optional(string)
  })
  default = null
}

################################################################################
# Optional Variables - Transparent Data Encryption
################################################################################

variable "transparent_data_encryption_key_vault_key_id" {
  description = "The Key Vault Key ID for Transparent Data Encryption (TDE) with customer-managed key."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
