#############################################################################
# VARIABLES STORAGE SHARE
#############################################################################
variable "storage_share_name" {
  description = "value to set the storage share name"
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

variable "quota" {
  description = "value to set the quota"
  type        = number
}

variable "access_tier" {
  description = "value to set the access tier"
  type        = string
  default     = null
}

variable "enabled_protocol" {
  description = "value to set the enabled protocol"
  type        = string
  default     = null
}

variable "metadata" {
  description = "value to set the metadata"
  type        = map(string)
  default     = null
}

variable "acl" {
  description = "value to set the acl"
  type = list(object({
    id = string
    access_policy = optional(object({
      start       = optional(string)
      expiry      = optional(string)
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
