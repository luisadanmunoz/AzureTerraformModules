################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the API Management service."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region."
  type        = string
}

variable "publisher_name" {
  description = "The name of the publisher."
  type        = string
}

variable "publisher_email" {
  description = "The email of the publisher."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the API Management service."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "sku_name" {
  description = "The SKU name. Format: {tier}_{capacity}. Possible tiers: Consumption, Developer, Basic, Standard, Premium."
  type        = string
  default     = "Developer_1"
}

variable "min_api_version" {
  description = "The minimum supported API version."
  type        = string
  default     = null
}

variable "virtual_network_type" {
  description = "The virtual network type. Possible values: None, External, Internal."
  type        = string
  default     = "None"
}

variable "virtual_network_subnet_id" {
  description = "The subnet ID for VNet integration."
  type        = string
  default     = null
}

variable "notification_sender_email" {
  description = "The email address from which notifications will be sent."
  type        = string
  default     = null
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity. Possible values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "List of User Assigned Identity IDs."
  type        = list(string)
  default     = []
}

################################################################################
# Optional - Protocols
################################################################################

variable "protocols" {
  description = "Protocol configuration for the API Management service."
  type = object({
    enable_http2 = optional(bool, false)
  })
  default = null
}

################################################################################
# Optional - Security
################################################################################

variable "security" {
  description = "Security configuration."
  type = object({
    enable_backend_ssl30      = optional(bool, false)
    enable_backend_tls10      = optional(bool, false)
    enable_backend_tls11      = optional(bool, false)
    enable_frontend_ssl30     = optional(bool, false)
    enable_frontend_tls10     = optional(bool, false)
    enable_frontend_tls11     = optional(bool, false)
    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool, false)
    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool, false)
    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool, false)
    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool, false)
    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool, false)
    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool, false)
    tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = optional(bool, false)
  })
  default = null
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
