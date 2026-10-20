#############################################################################
# VARIABLES IOT HUB ENDPOINT COSMOSDB ACCOUNT
#############################################################################
variable "iothub_endpoint_cosmosdb_account_name" {
  description = "value to set the iot hub endpoint cosmosdb account name"
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

variable "database_name" {
  description = "value to set the database name"
  type        = string
}

variable "endpoint_uri" {
  description = "value to set the endpoint uri"
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

variable "partition_key_name" {
  description = "value to set the partition key name"
  type        = string
  default     = null
}

variable "partition_key_template" {
  description = "value to set the partition key template"
  type        = string
  default     = null
}

variable "primary_key" {
  description = "value to set the primary key"
  type        = string
  default     = null
}

variable "secondary_key" {
  description = "value to set the secondary key"
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
