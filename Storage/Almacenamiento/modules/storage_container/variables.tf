#############################################################################
# VARIABLES STORAGE CONTAINER
#############################################################################
variable "storage_container_name" {
  description = "value to set the storage container name"
  type        = string
}

variable "storage_account_id" {
  description = "value to set the storage account id"
  type        = string
  default     = null
}

variable "storage_account_name" {
  description = "value to set the storage account name"
  type        = string
  default     = null
}

variable "container_access_type" {
  description = "value to set the container access type"
  type        = string
  default     = null
}

variable "default_encryption_scope" {
  description = "value to set the default encryption scope"
  type        = string
  default     = null
}

variable "encryption_scope_override_enabled" {
  description = "value to set the encryption scope override enabled"
  type        = bool
  default     = null
}

variable "metadata" {
  description = "value to set the metadata"
  type        = map(string)
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
