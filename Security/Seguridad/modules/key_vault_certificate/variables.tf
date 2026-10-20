#############################################################################
# VARIABLES KEY VAULT CERTIFICATE
#############################################################################
variable "key_vault_certificate_name" {
  description = "value to set the key vault certificate name"
  type        = string
}

variable "key_vault_id" {
  description = "value to set the key vault id"
  type        = string
}

variable "certificate" {
  description = "value to set the certificate import block"
  type = object({
    contents = string
    password = optional(string)
  })
  default = null
}

variable "certificate_policy" {
  description = "value to set the certificate policy"
  type = object({
    issuer_parameters = object({
      name = string
    })
    key_properties = object({
      exportable = bool
      key_type   = string
      reuse_key  = bool
      curve      = optional(string)
      key_size   = optional(number)
    })
    lifetime_actions = optional(list(object({
      action = object({
        action_type = string
      })
      trigger = object({
        days_before_expiry  = optional(number)
        lifetime_percentage = optional(number)
      })
    })))
    secret_properties = object({
      content_type = string
    })
    x509_certificate_properties = object({
      subject            = string
      validity_in_months = number
      key_usage          = list(string)
      extended_key_usage = optional(list(string))
      subject_alternative_names = optional(object({
        dns_names = optional(list(string))
        emails    = optional(list(string))
        upns      = optional(list(string))
      }))
    })
  })
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
