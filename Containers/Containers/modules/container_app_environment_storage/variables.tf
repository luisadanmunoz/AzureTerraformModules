#############################################################################
# VARIABLES CONTAINER APP ENVIRONMENT STORAGE
#############################################################################
variable "container_app_environment_storage_name" {
  description = "value to set the container app environment storage name"
  type        = string
}

variable "container_app_environment_id" {
  description = "value to set the container app environment id"
  type        = string
}

variable "account_name" {
  description = "value to set the account name"
  type        = string
  default     = null
}

variable "access_key" {
  description = "value to set the access key"
  type        = string
  default     = null
  sensitive   = true
}

variable "share_name" {
  description = "value to set the share name"
  type        = string
}

variable "access_mode" {
  description = "value to set the access mode"
  type        = string
}

variable "nfs_server_url" {
  description = "value to set the nfs server url"
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
