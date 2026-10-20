#############################################################################
# VARIABLES IOT HUB ENDPOINT SERVICEBUS TOPIC
#############################################################################
variable "iothub_endpoint_servicebus_topic_name" {
  description = "value to set the iot hub endpoint servicebus topic name"
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

variable "entity_path" {
  description = "value to set the entity path"
  type        = string
  default     = null
}

variable "identity_id" {
  description = "value to set the identity id"
  type        = string
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
