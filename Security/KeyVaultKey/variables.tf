################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Key Vault Key."
  type        = string
}

# DEPENDENCY: Key Vault must exist
variable "key_vault_id" {
  description = "The ID of the Key Vault where the key will be created."
  type        = string
}

variable "key_type" {
  description = "The type of the Key Vault Key (RSA, RSA-HSM, EC, EC-HSM, oct)."
  type        = string

  validation {
    condition     = contains(["RSA", "RSA-HSM", "EC", "EC-HSM", "oct"], var.key_type)
    error_message = "Key type must be one of: RSA, RSA-HSM, EC, EC-HSM, oct."
  }
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "key_size" {
  description = "The size of the RSA key in bits (2048, 3072, 4096). Only applicable for RSA key types."
  type        = number
  default     = 2048

  validation {
    condition     = contains([2048, 3072, 4096], var.key_size)
    error_message = "Key size must be 2048, 3072, or 4096."
  }
}

variable "curve" {
  description = "The EC curve name (P-256, P-256K, P-384, P-521). Only applicable for EC key types."
  type        = string
  default     = null

  validation {
    condition     = var.curve == null || contains(["P-256", "P-256K", "P-384", "P-521"], var.curve)
    error_message = "Curve must be one of: P-256, P-256K, P-384, P-521."
  }
}

variable "key_opts" {
  description = "A list of key operations permitted for this key."
  type        = list(string)
  default     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
}

variable "expiration_date" {
  description = "The expiration date of the key in UTC (ISO 8601 format)."
  type        = string
  default     = null
}

variable "not_before_date" {
  description = "The date before which the key is not valid in UTC (ISO 8601 format)."
  type        = string
  default     = null
}

variable "rotation_policy" {
  description = "The rotation policy for the key."
  type = object({
    expire_after         = optional(string)
    notify_before_expiry = optional(string)
    automatic = optional(object({
      time_after_creation = optional(string)
      time_before_expiry  = optional(string)
    }))
  })
  default = null
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the key."
  type        = map(string)
  default     = {}
}
