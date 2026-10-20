################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Disk Encryption Set."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the DES should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Disk Encryption Set. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'des'."
  type        = string
  default     = "des"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "disk"
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
# Disk Encryption Set Configuration
################################################################################

variable "key_vault_key_id" {
  description = "(Required) The ID of the Key Vault Key for encryption. DEPENDENCY: Key Vault Key must exist."
  type        = string
}

variable "encryption_type" {
  description = "(Optional) Encryption type. Values: EncryptionAtRestWithCustomerKey, EncryptionAtRestWithPlatformAndCustomerKeys, ConfidentialVmEncryptedWithCustomerKey. Default: EncryptionAtRestWithCustomerKey."
  type        = string
  default     = "EncryptionAtRestWithCustomerKey"

  validation {
    condition = contains([
      "EncryptionAtRestWithCustomerKey",
      "EncryptionAtRestWithPlatformAndCustomerKeys",
      "ConfidentialVmEncryptedWithCustomerKey"
    ], var.encryption_type)
    error_message = "encryption_type must be a valid encryption type."
  }
}

variable "auto_key_rotation_enabled" {
  description = "(Optional) Enable automatic key rotation. Default: true."
  type        = bool
  default     = true
}

variable "federated_client_id" {
  description = "(Optional) The federated client ID for multi-tenant encryption."
  type        = string
  default     = null
}

################################################################################
# Identity
################################################################################

variable "identity_type" {
  description = "(Optional) Identity type. Values: SystemAssigned, UserAssigned. Default: SystemAssigned."
  type        = string
  default     = "SystemAssigned"

  validation {
    condition     = contains(["SystemAssigned", "UserAssigned"], var.identity_type)
    error_message = "identity_type must be either 'SystemAssigned' or 'UserAssigned'."
  }
}

variable "identity_ids" {
  description = "(Optional) List of User Assigned Identity IDs. Required when identity_type is UserAssigned."
  type        = list(string)
  default     = []
}

################################################################################
# Key Vault Access
################################################################################

variable "create_key_vault_access_policy" {
  description = "(Optional) Create Key Vault access policy for the DES identity. Default: true."
  type        = bool
  default     = true
}

variable "key_vault_id" {
  description = "(Optional) The ID of the Key Vault. Required if create_key_vault_access_policy is true. DEPENDENCY: Key Vault must exist."
  type        = string
  default     = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
