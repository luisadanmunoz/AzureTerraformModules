################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the IoT Hub."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the IoT Hub."
  type        = string
}

variable "location" {
  description = "The Azure region where the IoT Hub should be created."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the IoT Hub resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - SKU Configuration
################################################################################

variable "sku_name" {
  description = "The name of the SKU. Possible values are B1, B2, B3, F1, S1, S2, and S3."
  type        = string
  default     = "S1"

  validation {
    condition     = contains(["B1", "B2", "B3", "F1", "S1", "S2", "S3"], var.sku_name)
    error_message = "The sku_name must be one of: B1, B2, B3, F1, S1, S2, S3."
  }
}

variable "sku_capacity" {
  description = "The number of provisioned IoT Hub units."
  type        = number
  default     = 1
}

################################################################################
# Optional - Configuration
################################################################################

variable "event_hub_partition_count" {
  description = "The number of partitions for the Event Hub-compatible endpoint."
  type        = number
  default     = 4
}

variable "event_hub_retention_in_days" {
  description = "The retention time for device-to-cloud messages in days."
  type        = number
  default     = 1
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the IoT Hub."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "The minimum TLS version to support. Possible values are 1.0, 1.1, and 1.2."
  type        = string
  default     = "1.2"
}

variable "local_authentication_enabled" {
  description = "Whether local authentication methods are enabled."
  type        = bool
  default     = true
}

################################################################################
# Optional - Cloud to Device
################################################################################

variable "cloud_to_device" {
  description = "Cloud to device messaging configuration."
  type = object({
    max_delivery_count = optional(number, 10)
    default_ttl        = optional(string, "PT1H")
    feedback = optional(object({
      time_to_live       = optional(string, "PT1H")
      max_delivery_count = optional(number, 10)
      lock_duration      = optional(string, "PT60S")
    }))
  })
  default = null
}

################################################################################
# Optional - File Upload
################################################################################

variable "file_upload" {
  description = "File upload configuration."
  type = object({
    connection_string   = string
    container_name      = string
    sas_ttl             = optional(string, "PT1H")
    notifications       = optional(bool, false)
    lock_duration       = optional(string, "PT1M")
    default_ttl         = optional(string, "PT1H")
    max_delivery_count  = optional(number, 10)
    authentication_type = optional(string)
    identity_id         = optional(string)
  })
  default   = null
  sensitive = true
}

################################################################################
# Optional - Network
################################################################################

variable "network_rule_sets" {
  description = "Network rule sets configuration."
  type = list(object({
    default_action                     = optional(string, "Deny")
    apply_to_builtin_eventhub_endpoint = optional(bool, false)
    ip_rules = optional(list(object({
      name    = string
      ip_mask = string
      action  = optional(string, "Allow")
    })), [])
  }))
  default = []
}

################################################################################
# Optional - Endpoints
################################################################################

variable "endpoints" {
  description = "Custom endpoints configuration."
  type = list(object({
    type                       = string
    name                       = string
    authentication_type        = optional(string)
    identity_id                = optional(string)
    endpoint_uri               = optional(string)
    entity_path                = optional(string)
    connection_string          = optional(string)
    batch_frequency_in_seconds = optional(number)
    max_chunk_size_in_bytes    = optional(number)
    container_name             = optional(string)
    encoding                   = optional(string)
    file_name_format           = optional(string)
    resource_group_name        = optional(string)
  }))
  default   = []
  sensitive = true
}

################################################################################
# Optional - Routes
################################################################################

variable "routes" {
  description = "Message routing configuration."
  type = list(object({
    name           = string
    source         = string
    condition      = optional(string)
    endpoint_names = list(string)
    enabled        = optional(bool, true)
  }))
  default = []
}

variable "fallback_route" {
  description = "Fallback route configuration."
  type = object({
    source         = optional(string, "DeviceMessages")
    condition      = optional(string, "true")
    endpoint_names = optional(list(string), ["events"])
    enabled        = optional(bool, true)
  })
  default = null
}

################################################################################
# Optional - Enrichments
################################################################################

variable "enrichments" {
  description = "Message enrichments configuration."
  type = list(object({
    key            = string
    value          = string
    endpoint_names = list(string)
  }))
  default = []
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity. Possible values are SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "A list of user-assigned managed identity IDs."
  type        = list(string)
  default     = []
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the IoT Hub."
  type        = map(string)
  default     = {}
}
