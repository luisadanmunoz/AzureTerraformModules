# -----------------------------------------------------------------------------
# REQUIRED VARIABLES
# -----------------------------------------------------------------------------

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Event Grid System Topic. DEPENDENCY: Resource group must exist."
  type        = string
}

variable "location" {
  description = "The Azure region where the Event Grid System Topic will be created."
  type        = string
}

variable "source_arm_resource_id" {
  description = "The ARM resource ID of the source resource. DEPENDENCY: The source resource (e.g., storage account, resource group, event hub namespace) must exist."
  type        = string
}

variable "topic_type" {
  description = "The type of the source resource. Examples: 'Microsoft.Storage.StorageAccounts', 'Microsoft.Resources.ResourceGroups', 'Microsoft.EventHub.Namespaces', 'Microsoft.ServiceBus.Namespaces', 'Microsoft.ContainerRegistry.Registries'."
  type        = string
}

# -----------------------------------------------------------------------------
# OPTIONAL VARIABLES - NAMING
# -----------------------------------------------------------------------------

variable "name" {
  description = "The exact name of the Event Grid System Topic. If provided, overrides the generated name from name_prefix/workload/environment/instance."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix to use for the generated name. Default is 'evgst' (Event Grid System Topic)."
  type        = string
  default     = "evgst"
}

variable "workload" {
  description = "The workload name to include in the generated name."
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name to include in the generated name (e.g., dev, staging, prod)."
  type        = string
  default     = null
}

variable "instance" {
  description = "The instance identifier to include in the generated name."
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# OPTIONAL VARIABLES - FEATURE FLAGS
# -----------------------------------------------------------------------------

variable "create" {
  description = "Whether to create the Event Grid System Topic resource."
  type        = bool
  default     = true
}

# -----------------------------------------------------------------------------
# OPTIONAL VARIABLES - IDENTITY
# -----------------------------------------------------------------------------

variable "identity" {
  description = <<-EOT
    Identity configuration for the Event Grid System Topic.
    - type: The type of identity. Possible values are 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'.
    - identity_ids: A list of User Assigned Identity IDs to assign. Required when type includes 'UserAssigned'.
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null
}

# -----------------------------------------------------------------------------
# OPTIONAL VARIABLES - EVENT SUBSCRIPTIONS
# -----------------------------------------------------------------------------

variable "event_subscriptions" {
  description = <<-EOT
    A map of event subscriptions to create for this system topic.
    Each subscription can have the following attributes:
    - event_delivery_schema: The event delivery schema. Possible values are 'EventGridSchema', 'CloudEventSchemaV1_0', 'CustomInputSchema'. Default: 'EventGridSchema'.
    - included_event_types: A list of event types to include. If not specified, all event types are included.
    - subject_filter: An object with optional 'subject_begins_with' and 'subject_ends_with' strings, and 'case_sensitive' boolean.
    - advanced_filter: An object with filter configurations.
    - expiration_time_utc: The expiration time of the subscription in UTC.
    - labels: A list of labels for the subscription.
    - advanced_filtering_on_arrays_enabled: Whether advanced filtering on arrays is enabled.

    Endpoint configuration (specify one):
    - webhook_endpoint: Object with 'url', optional 'max_events_per_batch', 'preferred_batch_size_in_kilobytes', 'active_directory_tenant_id', 'active_directory_app_id_or_uri'.
    - storage_queue_endpoint: Object with 'storage_account_id' and 'queue_name', optional 'queue_message_time_to_live_in_seconds'.
    - eventhub_endpoint_id: The resource ID of an Event Hub to deliver events to.
    - service_bus_queue_endpoint_id: The resource ID of a Service Bus Queue to deliver events to.
    - service_bus_topic_endpoint_id: The resource ID of a Service Bus Topic to deliver events to.
    - azure_function_endpoint: Object with 'function_id', optional 'max_events_per_batch', 'preferred_batch_size_in_kilobytes'.

    Retry and dead letter configuration:
    - retry_policy: Object with 'max_delivery_attempts' (1-30) and 'event_time_to_live' (1-1440 minutes).
    - storage_blob_dead_letter_destination: Object with 'storage_account_id' and 'storage_blob_container_name'.
  EOT
  type = map(object({
    event_delivery_schema                 = optional(string, "EventGridSchema")
    included_event_types                  = optional(list(string))
    expiration_time_utc                   = optional(string)
    labels                                = optional(list(string))
    advanced_filtering_on_arrays_enabled  = optional(bool, false)

    subject_filter = optional(object({
      subject_begins_with = optional(string)
      subject_ends_with   = optional(string)
      case_sensitive      = optional(bool, false)
    }))

    advanced_filter = optional(object({
      bool_equals = optional(list(object({
        key   = string
        value = bool
      })), [])
      number_greater_than = optional(list(object({
        key   = string
        value = number
      })), [])
      number_greater_than_or_equals = optional(list(object({
        key   = string
        value = number
      })), [])
      number_less_than = optional(list(object({
        key   = string
        value = number
      })), [])
      number_less_than_or_equals = optional(list(object({
        key   = string
        value = number
      })), [])
      number_in = optional(list(object({
        key    = string
        values = list(number)
      })), [])
      number_not_in = optional(list(object({
        key    = string
        values = list(number)
      })), [])
      number_in_range = optional(list(object({
        key    = string
        values = list(list(number))
      })), [])
      number_not_in_range = optional(list(object({
        key    = string
        values = list(list(number))
      })), [])
      string_begins_with = optional(list(object({
        key    = string
        values = list(string)
      })), [])
      string_ends_with = optional(list(object({
        key    = string
        values = list(string)
      })), [])
      string_contains = optional(list(object({
        key    = string
        values = list(string)
      })), [])
      string_not_begins_with = optional(list(object({
        key    = string
        values = list(string)
      })), [])
      string_not_ends_with = optional(list(object({
        key    = string
        values = list(string)
      })), [])
      string_not_contains = optional(list(object({
        key    = string
        values = list(string)
      })), [])
      string_in = optional(list(object({
        key    = string
        values = list(string)
      })), [])
      string_not_in = optional(list(object({
        key    = string
        values = list(string)
      })), [])
      is_null_or_undefined = optional(list(object({
        key = string
      })), [])
      is_not_null = optional(list(object({
        key = string
      })), [])
    }))

    webhook_endpoint = optional(object({
      url                               = string
      max_events_per_batch              = optional(number)
      preferred_batch_size_in_kilobytes = optional(number)
      active_directory_tenant_id        = optional(string)
      active_directory_app_id_or_uri    = optional(string)
    }))

    storage_queue_endpoint = optional(object({
      storage_account_id                    = string
      queue_name                            = string
      queue_message_time_to_live_in_seconds = optional(number)
    }))

    eventhub_endpoint_id           = optional(string)
    service_bus_queue_endpoint_id  = optional(string)
    service_bus_topic_endpoint_id  = optional(string)

    azure_function_endpoint = optional(object({
      function_id                       = string
      max_events_per_batch              = optional(number)
      preferred_batch_size_in_kilobytes = optional(number)
    }))

    retry_policy = optional(object({
      max_delivery_attempts = optional(number, 30)
      event_time_to_live    = optional(number, 1440)
    }))

    storage_blob_dead_letter_destination = optional(object({
      storage_account_id          = string
      storage_blob_container_name = string
    }))
  }))
  default = {}
}

# -----------------------------------------------------------------------------
# OPTIONAL VARIABLES - TAGS
# -----------------------------------------------------------------------------

variable "tags" {
  description = "A map of tags to assign to the Event Grid System Topic."
  type        = map(string)
  default     = {}
}
