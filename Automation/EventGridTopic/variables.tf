# ==============================================================================
# Common Variables
# ==============================================================================

variable "create" {
  description = "Controls whether the Event Grid Topic should be created."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Event Grid Topic. # DEPENDENCY: azurerm_resource_group"
  type        = string
}

variable "location" {
  description = "The Azure region where the Event Grid Topic should be created."
  type        = string
}

# ==============================================================================
# Naming Variables
# ==============================================================================

variable "name" {
  description = "The name of the Event Grid Topic. If provided, overrides the generated name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The prefix for the generated Event Grid Topic name."
  type        = string
  default     = "evgt"
}

variable "workload" {
  description = "The workload name to use for the generated name."
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name to use for the generated name."
  type        = string
  default     = null
}

variable "instance" {
  description = "The instance identifier to use for the generated name."
  type        = string
  default     = null
}

# ==============================================================================
# Tags
# ==============================================================================

variable "tags" {
  description = "A mapping of tags to assign to the Event Grid Topic."
  type        = map(string)
  default     = {}
}

# ==============================================================================
# Event Grid Topic Specific Variables
# ==============================================================================

variable "input_schema" {
  description = "The schema in which incoming events will be published. Allowed values are EventGridSchema, CustomEventSchema, or CloudEventSchemaV1_0."
  type        = string
  default     = "EventGridSchema"

  validation {
    condition     = contains(["EventGridSchema", "CustomEventSchema", "CloudEventSchemaV1_0"], var.input_schema)
    error_message = "The input_schema must be one of: EventGridSchema, CustomEventSchema, CloudEventSchemaV1_0."
  }
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this Event Grid Topic."
  type        = bool
  default     = true
}

variable "local_auth_enabled" {
  description = "Whether or not local authentication is enabled for this Event Grid Topic."
  type        = bool
  default     = true
}

variable "input_mapping_fields" {
  description = "A mapping of input field names to their corresponding schema fields. Only applicable when input_schema is CustomEventSchema."
  type = object({
    id           = optional(string)
    topic        = optional(string)
    event_time   = optional(string)
    event_type   = optional(string)
    subject      = optional(string)
    data_version = optional(string)
  })
  default = null
}

variable "input_mapping_default_values" {
  description = "Default values used when the input event does not include certain fields. Only applicable when input_schema is CustomEventSchema."
  type = object({
    event_type   = optional(string)
    subject      = optional(string)
    data_version = optional(string)
  })
  default = null
}

variable "inbound_ip_rule" {
  description = "A list of inbound IP rules for the Event Grid Topic."
  type = list(object({
    ip_mask = string
    action  = optional(string, "Allow")
  }))
  default = []
}

variable "identity" {
  description = "An identity block for the Event Grid Topic."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], try(var.identity.type, "SystemAssigned"))
    error_message = "The identity type must be one of: SystemAssigned, UserAssigned, or 'SystemAssigned, UserAssigned'."
  }
}
