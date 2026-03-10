################################################################################
# Required Variables
################################################################################

# DEPENDENCY: Resource Group must exist
variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Key Vault will be created."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID for the Key Vault."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the Key Vault. Must be globally unique."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the Key Vault name."
  type        = string
  default     = "kv"
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

variable "sku_name" {
  description = "The SKU name for the Key Vault. Possible values are standard and premium."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "SKU name must be standard or premium."
  }
}

variable "enabled_for_deployment" {
  description = "Allow Azure VMs to retrieve certificates."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Allow Azure Disk Encryption to retrieve secrets."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Allow ARM templates to retrieve secrets."
  type        = bool
  default     = false
}

variable "enable_rbac_authorization" {
  description = "Use RBAC instead of access policies."
  type        = bool
  default     = true
}

variable "purge_protection_enabled" {
  description = "Enable purge protection (recommended for production)."
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain deleted vaults (7-90)."
  type        = number
  default     = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "Soft delete retention must be between 7 and 90 days."
  }
}

variable "public_network_access_enabled" {
  description = "Allow public network access to the Key Vault."
  type        = bool
  default     = true
}

################################################################################
# Optional Variables - Network ACLs
################################################################################

variable "network_acls" {
  description = "Network ACL configuration for the Key Vault."
  type = object({
    bypass                     = optional(string, "AzureServices")
    default_action             = optional(string, "Deny")
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default = null
}

################################################################################
# Optional Variables - Access Policies (when not using RBAC)
################################################################################

variable "access_policies" {
  description = "List of access policies for the Key Vault (ignored if RBAC is enabled)."
  type = list(object({
    tenant_id               = optional(string)
    object_id               = string
    application_id          = optional(string)
    certificate_permissions = optional(list(string), [])
    key_permissions         = optional(list(string), [])
    secret_permissions      = optional(list(string), [])
    storage_permissions     = optional(list(string), [])
  }))
  default = []
}

################################################################################
# Optional Variables - Contacts
################################################################################

variable "contacts" {
  description = "List of contacts for certificate notifications."
  type = list(object({
    email = string
    name  = optional(string)
    phone = optional(string)
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
