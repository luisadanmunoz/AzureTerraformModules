################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Key Vault Secret."
  type        = string
}

# DEPENDENCY: Key Vault must exist
variable "key_vault_id" {
  description = "The ID of the Key Vault where the secret will be stored."
  type        = string
}

variable "value" {
  description = "The value of the secret."
  type        = string
  sensitive   = true
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "content_type" {
  description = "The content type of the secret (e.g., text/plain, application/json)."
  type        = string
  default     = null
}

variable "not_before_date" {
  description = "The date before which the secret is not valid (ISO 8601 format)."
  type        = string
  default     = null
}

variable "expiration_date" {
  description = "The date after which the secret expires (ISO 8601 format)."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the secret."
  type        = map(string)
  default     = {}
}
