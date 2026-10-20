#############################################################################
# VARIABLES MACHINE LEARNING DATASTORE FILESHARE
#############################################################################
variable "machine_learning_datastore_fileshare_name" {
  description = "value to set the machine learning datastore fileshare name"
  type        = string
}

variable "workspace_id" {
  description = "value to set the machine learning workspace id"
  type        = string
}

variable "storage_fileshare_id" {
  description = "value to set the storage fileshare id"
  type        = string
}

variable "account_key" {
  description = "value to set the account key"
  type        = string
  default     = null
}

variable "shared_access_signature" {
  description = "value to set the shared access signature"
  type        = string
  default     = null
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "service_data_identity" {
  description = "value to set the service data identity"
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
