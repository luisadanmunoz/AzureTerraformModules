#############################################################################
# VARIABLES STORAGE TABLE
#############################################################################
variable "storage_table_name" {
  description = "value to set the storage table name"
  type        = string
}

variable "storage_account_name" {
  description = "value to set the storage account name"
  type        = string
}

variable "acl" {
  description = "value to set the acl"
  type = list(object({
    id = string
    access_policy = optional(object({
      start       = string
      expiry      = string
      permissions = string
    }))
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
