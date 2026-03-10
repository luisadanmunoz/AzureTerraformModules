################################################################################
# Required Variables
################################################################################

variable "iothub_id" {
  description = "The ID of the IoT Hub."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the endpoint resources."
  type        = bool
  default     = true
}

################################################################################
# Optional - Storage Container Endpoint
################################################################################

variable "storage_container_endpoint" {
  description = "Storage container endpoint configuration."
  type = object({
    name                       = string
    container_name             = string
    authentication_type        = optional(string, "keyBased")
    connection_string          = optional(string)
    identity_id                = optional(string)
    endpoint_uri               = optional(string)
    batch_frequency_in_seconds = optional(number, 300)
    max_chunk_size_in_bytes    = optional(number, 314572800)
    encoding                   = optional(string, "Avro")
    file_name_format           = optional(string, "{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}")
  })
  default   = null
  sensitive = true
}

################################################################################
# Optional - Event Hub Endpoint
################################################################################

variable "eventhub_endpoint" {
  description = "Event Hub endpoint configuration."
  type = object({
    name                = string
    authentication_type = optional(string, "keyBased")
    connection_string   = optional(string)
    identity_id         = optional(string)
    endpoint_uri        = optional(string)
    entity_path         = optional(string)
  })
  default   = null
  sensitive = true
}

################################################################################
# Optional - Service Bus Queue Endpoint
################################################################################

variable "servicebus_queue_endpoint" {
  description = "Service Bus Queue endpoint configuration."
  type = object({
    name                = string
    authentication_type = optional(string, "keyBased")
    connection_string   = optional(string)
    identity_id         = optional(string)
    endpoint_uri        = optional(string)
    entity_path         = optional(string)
  })
  default   = null
  sensitive = true
}

################################################################################
# Optional - Service Bus Topic Endpoint
################################################################################

variable "servicebus_topic_endpoint" {
  description = "Service Bus Topic endpoint configuration."
  type = object({
    name                = string
    authentication_type = optional(string, "keyBased")
    connection_string   = optional(string)
    identity_id         = optional(string)
    endpoint_uri        = optional(string)
    entity_path         = optional(string)
  })
  default   = null
  sensitive = true
}

################################################################################
# Optional - Cosmos DB Endpoint
################################################################################

variable "cosmosdb_endpoint" {
  description = "Cosmos DB endpoint configuration."
  type = object({
    name                       = string
    container_name             = string
    database_name              = string
    authentication_type        = optional(string, "keyBased")
    primary_key                = optional(string)
    secondary_key              = optional(string)
    identity_id                = optional(string)
    endpoint_uri               = optional(string)
    partition_key_name         = optional(string)
    partition_key_template     = optional(string)
  })
  default   = null
  sensitive = true
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags (not applied to resources, kept for consistency)."
  type        = map(string)
  default     = {}
}
