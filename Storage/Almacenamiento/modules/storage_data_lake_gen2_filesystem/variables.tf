#############################################################################
# VARIABLES STORAGE DATA LAKE GEN2 FILESYSTEM
#############################################################################
variable "storage_data_lake_gen2_filesystem_name" {
  description = "value to set the storage data lake gen2 filesystem name"
  type        = string
}

variable "storage_account_id" {
  description = "value to set the storage account id"
  type        = string
}

variable "default_encryption_scope" {
  description = "value to set the default encryption scope"
  type        = string
  default     = null
}

variable "properties" {
  description = "value to set the properties"
  type        = map(string)
  default     = null
}

variable "ace" {
  description = "value to set the ace"
  type = list(object({
    id          = optional(string)
    permissions = string
    scope       = optional(string)
    type        = string
  }))
  default = []
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
