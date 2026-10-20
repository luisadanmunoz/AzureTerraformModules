#############################################################################
# VARIABLES KEY VAULT SECRET
#############################################################################
variable "key_vault_secret_name" {
  description = "value to set the key vault secret name"
  type        = string
}

variable "key_vault_id" {
  description = "value to set the key vault id"
  type        = string
}

variable "value" {
  description = "value to set the secret value"
  type        = string
  default     = null
  sensitive   = true
}

variable "value_wo" {
  description = "value to set the write only secret value"
  type        = string
  default     = null
  sensitive   = true
}

variable "value_wo_version" {
  description = "value to set the write only value version"
  type        = number
  default     = null
}

variable "content_type" {
  description = "value to set the content type"
  type        = string
  default     = null
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
