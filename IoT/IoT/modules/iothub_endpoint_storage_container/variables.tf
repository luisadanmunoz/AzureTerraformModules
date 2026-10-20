#############################################################################
# VARIABLES IOT HUB ENDPOINT STORAGE CONTAINER
#############################################################################
variable "iothub_endpoint_storage_container_name" {
  description = "value to set the iot hub endpoint storage container name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "iothub_id" {
  description = "value to set the iot hub id"
  type        = string
}

variable "container_name" {
  description = "value to set the container name"
  type        = string
}

variable "authentication_type" {
  description = "value to set the authentication type"
  type        = string
  default     = null
}

variable "connection_string" {
  description = "value to set the connection string"
  type        = string
  default     = null
}

variable "endpoint_uri" {
  description = "value to set the endpoint uri"
  type        = string
  default     = null
}

variable "identity_id" {
  description = "value to set the identity id"
  type        = string
  default     = null
}

variable "batch_frequency_in_seconds" {
  description = "value to set the batch frequency in seconds"
  type        = number
  default     = null
}

variable "encoding" {
  description = "value to set the encoding"
  type        = string
  default     = null
}

variable "file_name_format" {
  description = "value to set the file name format"
  type        = string
  default     = null
}

variable "max_chunk_size_in_bytes" {
  description = "value to set the max chunk size in bytes"
  type        = number
  default     = null
}

variable "subscription_id" {
  description = "value to set the subscription id"
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
