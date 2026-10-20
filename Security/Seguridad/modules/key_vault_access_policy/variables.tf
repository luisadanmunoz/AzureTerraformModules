#############################################################################
# VARIABLES KEY VAULT ACCESS POLICY
#############################################################################
variable "key_vault_id" {
  description = "value to set the key vault id"
  type        = string
}

variable "tenant_id" {
  description = "value to set the tenant id"
  type        = string
}

variable "object_id" {
  description = "value to set the object id"
  type        = string
}

variable "application_id" {
  description = "value to set the application id"
  type        = string
  default     = null
}

variable "certificate_permissions" {
  description = "value to set the certificate permissions"
  type        = list(string)
  default     = null
}

variable "key_permissions" {
  description = "value to set the key permissions"
  type        = list(string)
  default     = null
}

variable "secret_permissions" {
  description = "value to set the secret permissions"
  type        = list(string)
  default     = null
}

variable "storage_permissions" {
  description = "value to set the storage permissions"
  type        = list(string)
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
