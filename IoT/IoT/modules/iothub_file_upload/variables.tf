#############################################################################
# VARIABLES IOT HUB FILE UPLOAD
#############################################################################
variable "iothub_id" {
  description = "value to set the iot hub id"
  type        = string
}

variable "connection_string" {
  description = "value to set the connection string"
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

variable "identity_id" {
  description = "value to set the identity id"
  type        = string
  default     = null
}

variable "default_ttl" {
  description = "value to set the default ttl"
  type        = string
  default     = null
}

variable "lock_duration" {
  description = "value to set the lock duration"
  type        = string
  default     = null
}

variable "max_delivery_count" {
  description = "value to set the max delivery count"
  type        = number
  default     = null
}

variable "notifications_enabled" {
  description = "value to set the notifications enabled flag"
  type        = bool
  default     = null
}

variable "sas_ttl" {
  description = "value to set the sas ttl"
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
