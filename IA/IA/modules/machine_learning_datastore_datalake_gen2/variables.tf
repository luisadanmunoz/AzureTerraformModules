#############################################################################
# VARIABLES MACHINE LEARNING DATASTORE DATALAKE GEN2
#############################################################################
variable "machine_learning_datastore_datalake_gen2_name" {
  description = "value to set the machine learning datastore datalake gen2 name"
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

variable "authority_url" {
  description = "value to set the authority url"
  type        = string
  default     = null
}

variable "client_id" {
  description = "value to set the client id"
  type        = string
  default     = null
}

variable "client_secret" {
  description = "value to set the client secret"
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

variable "tenant_id" {
  description = "value to set the tenant id"
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
