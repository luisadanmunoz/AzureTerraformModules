# -----------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# -----------------------------------------------------------------------------

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Event Grid Domain. DEPENDENCY: Must be an existing resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where the Event Grid Domain should be created."
  type        = string
}

# -----------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# -----------------------------------------------------------------------------

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the Event Grid Domain. If provided, overrides the generated name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The prefix to use for the generated Event Grid Domain name."
  type        = string
  default     = "evgd"
}

variable "workload" {
  description = "The workload name to use in the generated Event Grid Domain name."
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name to use in the generated Event Grid Domain name."
  type        = string
  default     = null
}

variable "instance" {
  description = "The instance identifier to use in the generated Event Grid Domain name."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# -----------------------------------------------------------------------------
# EVENT GRID DOMAIN SPECIFIC PARAMETERS
# -----------------------------------------------------------------------------

variable "input_schema" {
  description = "Specifies the schema in which incoming events will be published to this domain. Allowed values are 'EventGridSchema', 'CustomEventSchema', or 'CloudEventSchemaV1_0'."
  type        = string
  default     = "EventGridSchema"

  validation {
    condition     = contains(["EventGridSchema", "CustomEventSchema", "CloudEventSchemaV1_0"], var.input_schema)
    error_message = "The input_schema must be one of: EventGridSchema, CustomEventSchema, CloudEventSchemaV1_0."
  }
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this Event Grid Domain."
  type        = bool
  default     = true
}

variable "local_auth_enabled" {
  description = "Whether local authentication methods (SAS keys) is enabled for the Event Grid Domain."
  type        = bool
  default     = true
}

variable "auto_create_topic_with_first_subscription" {
  description = "Whether to automatically create a topic when a subscription is created for the first time."
  type        = bool
  default     = true
}

variable "auto_delete_topic_with_last_subscription" {
  description = "Whether to automatically delete a topic when the last subscription is deleted."
  type        = bool
  default     = true
}

variable "input_mapping_fields" {
  description = "A mapping of input fields to Event Grid schema fields when using CustomEventSchema."
  type = object({
    id           = optional(string)
    topic        = optional(string)
    event_type   = optional(string)
    event_time   = optional(string)
    data_version = optional(string)
    subject      = optional(string)
  })
  default = null
}

variable "input_mapping_default_values" {
  description = "Default values for input mapping fields when using CustomEventSchema."
  type = object({
    event_type   = optional(string)
    data_version = optional(string)
    subject      = optional(string)
  })
  default = null
}

variable "inbound_ip_rule" {
  description = "A list of inbound IP rules to allow specific IP addresses or ranges."
  type = list(object({
    ip_mask = string
    action  = optional(string, "Allow")
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.inbound_ip_rule : contains(["Allow"], rule.action)
    ])
    error_message = "The action in inbound_ip_rule must be 'Allow'."
  }
}

variable "identity" {
  description = "An identity block for managed identity configuration."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "The identity type must be one of: SystemAssigned, UserAssigned, or 'SystemAssigned, UserAssigned'."
  }
}

variable "domain_topics" {
  description = "A map of domain topics to create within this Event Grid Domain. DEPENDENCY: The domain must be created first."
  type = map(object({
    name = string
  }))
  default = {}
}
