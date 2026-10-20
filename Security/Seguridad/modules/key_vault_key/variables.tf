#############################################################################
# VARIABLES KEY VAULT KEY
#############################################################################
variable "key_vault_key_name" {
  description = "value to set the key vault key name"
  type        = string
}

variable "key_vault_id" {
  description = "value to set the key vault id"
  type        = string
}

variable "key_type" {
  description = "value to set the key type"
  type        = string
}

variable "key_size" {
  description = "value to set the key size"
  type        = number
  default     = null
}

variable "curve" {
  description = "value to set the curve"
  type        = string
  default     = null
}

variable "key_opts" {
  description = "value to set the key options"
  type        = list(string)
}

variable "not_before_date" {
  description = "value to set the not before date"
  type        = string
  default     = null
}

variable "expiration_date" {
  description = "value to set the expiration date"
  type        = string
  default     = null
}

variable "rotation_policy" {
  description = "value to set the rotation policy"
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
