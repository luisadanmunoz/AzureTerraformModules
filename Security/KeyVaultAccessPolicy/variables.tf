################################################################################
# Required Variables
################################################################################

# DEPENDENCY: Key Vault must exist
variable "key_vault_id" {
  description = "The ID of the Key Vault where the access policy will be applied."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID for the access policy."
  type        = string
}

variable "object_id" {
  description = "The object ID of the principal (user, group, or service principal) for the access policy."
  type        = string
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "application_id" {
  description = "The application ID of the service principal for the access policy."
  type        = string
  default     = null
}

variable "certificate_permissions" {
  description = "List of certificate permissions granted to the principal."
  type        = list(string)
  default     = []
}

variable "key_permissions" {
  description = "List of key permissions granted to the principal."
  type        = list(string)
  default     = []
}

variable "secret_permissions" {
  description = "List of secret permissions granted to the principal."
  type        = list(string)
  default     = []
}

variable "storage_permissions" {
  description = "List of storage permissions granted to the principal."
  type        = list(string)
  default     = []
}
