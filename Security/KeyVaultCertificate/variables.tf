################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Key Vault Certificate."
  type        = string
}

# DEPENDENCY: Key Vault must exist
variable "key_vault_id" {
  description = "The ID of the Key Vault where the certificate will be stored."
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

variable "certificate" {
  description = "A PFX certificate to import. Use this to import an existing certificate."
  type = object({
    contents = string
    password = optional(string, "")
  })
  default   = null
  sensitive = true
}

variable "certificate_policy" {
  description = "The certificate policy for generating or managing the certificate."
  type = object({
    issuer_parameters = object({
      name = string
    })
    key_properties = object({
      exportable = bool
      key_type   = string
      key_size   = number
      reuse_key  = bool
    })
    secret_properties = object({
      content_type = string
    })
    lifetime_action = optional(list(object({
      action = object({
        action_type = string
      })
      trigger = object({
        days_before_expiry  = optional(number)
        lifetime_percentage = optional(number)
      })
    })), [])
    x509_certificate_properties = object({
      subject            = string
      validity_in_months = number
      key_usage          = list(string)
      extended_key_usage = optional(list(string), [])
      subject_alternative_names = optional(object({
        dns_names = optional(list(string), [])
        emails    = optional(list(string), [])
        upns      = optional(list(string), [])
      }))
    })
  })
  default = null
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the certificate."
  type        = map(string)
  default     = {}
}
