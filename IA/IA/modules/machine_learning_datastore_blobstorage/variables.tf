#############################################################################
# VARIABLES MACHINE LEARNING DATASTORE BLOB STORAGE
#############################################################################
variable "machine_learning_datastore_blobstorage_name" {
  description = "value to set the machine learning datastore blobstorage name"
  type        = string
}

variable "workspace_id" {
  description = "value to set the machine learning workspace id"
  type        = string
}

variable "storage_container_id" {
  description = "value to set the storage container id"
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

variable "is_default" {
  description = "value to set the default flag"
  type        = bool
  default     = null
}

variable "service_data_auth_identity" {
  description = "value to set the service data auth identity"
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
