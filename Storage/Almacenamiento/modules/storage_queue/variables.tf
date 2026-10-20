#############################################################################
# VARIABLES STORAGE QUEUE
#############################################################################
variable "storage_queue_name" {
  description = "value to set the storage queue name"
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
