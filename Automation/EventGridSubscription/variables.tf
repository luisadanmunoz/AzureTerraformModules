variable "create" {
  description = "Whether to create the Event Grid Subscription resource."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the Event Grid Subscription. Changing this forces a new resource to be created."
  type        = string
}

variable "scope" {
  description = "The resource ID to subscribe to events from. DEPENDENCY: The ID of the resource to subscribe to (e.g., Storage Account, Resource Group, Azure Subscription)."
  type        = string
}

variable "event_delivery_schema" {
  description = "The schema in which incoming events will be delivered. Possible values are 'EventGridSchema', 'CloudEventSchemaV1_0', or 'CustomInputSchema'."
  type        = string
  default     = "EventGridSchema"
}

variable "included_event_types" {
  description = "A list of event types to include. If not specified, all event types will be included."
  type        = list(string)
  default     = null
}

variable "subject_filter" {
  description = <<-EOF
    A subject_filter block for filtering events by subject.
    - subject_begins_with: (Optional) A string that the subject must begin with.
    - subject_ends_with: (Optional) A string that the subject must end with.
    - case_sensitive: (Optional) Whether the subject is case sensitive. Defaults to false.
  EOF
  type = object({
    subject_begins_with = optional(string)
    subject_ends_with   = optional(string)
    case_sensitive      = optional(bool, false)
  })
  default = null
}

variable "advanced_filter" {
  description = <<-EOF
    An advanced_filter block for advanced event filtering. Supports the following filter types:
    - bool_equals: (Optional) List of objects with key and value.
    - number_greater_than: (Optional) List of objects with key and value.
    - number_greater_than_or_equals: (Optional) List of objects with key and value.
    - number_less_than: (Optional) List of objects with key and value.
    - number_less_than_or_equals: (Optional) List of objects with key and value.
    - number_in: (Optional) List of objects with key and values.
    - number_not_in: (Optional) List of objects with key and values.
    - number_in_range: (Optional) List of objects with key and values.
    - number_not_in_range: (Optional) List of objects with key and values.
    - string_begins_with: (Optional) List of objects with key and values.
    - string_ends_with: (Optional) List of objects with key and values.
    - string_contains: (Optional) List of objects with key and values.
    - string_in: (Optional) List of objects with key and values.
    - string_not_in: (Optional) List of objects with key and values.
    - string_not_begins_with: (Optional) List of objects with key and values.
    - string_not_ends_with: (Optional) List of objects with key and values.
    - string_not_contains: (Optional) List of objects with key and values.
    - is_not_null: (Optional) List of objects with key.
    - is_null_or_undefined: (Optional) List of objects with key.
  EOF
  type = object({
    bool_equals                     = optional(list(object({ key = string, value = bool })))
    number_greater_than             = optional(list(object({ key = string, value = number })))
    number_greater_than_or_equals   = optional(list(object({ key = string, value = number })))
    number_less_than                = optional(list(object({ key = string, value = number })))
    number_less_than_or_equals      = optional(list(object({ key = string, value = number })))
    number_in                       = optional(list(object({ key = string, values = list(number) })))
    number_not_in                   = optional(list(object({ key = string, values = list(number) })))
    number_in_range                 = optional(list(object({ key = string, values = list(list(number)) })))
    number_not_in_range             = optional(list(object({ key = string, values = list(list(number)) })))
    string_begins_with              = optional(list(object({ key = string, values = list(string) })))
    string_ends_with                = optional(list(object({ key = string, values = list(string) })))
    string_contains                 = optional(list(object({ key = string, values = list(string) })))
    string_in                       = optional(list(object({ key = string, values = list(string) })))
    string_not_in                   = optional(list(object({ key = string, values = list(string) })))
    string_not_begins_with          = optional(list(object({ key = string, values = list(string) })))
    string_not_ends_with            = optional(list(object({ key = string, values = list(string) })))
    string_not_contains             = optional(list(object({ key = string, values = list(string) })))
    is_not_null                     = optional(list(object({ key = string })))
    is_null_or_undefined            = optional(list(object({ key = string })))
  })
  default = null
}

variable "delivery_identity" {
  description = <<-EOF
    A delivery_identity block for managed identity delivery.
    - type: (Required) The type of managed identity. Possible values are 'SystemAssigned' or 'UserAssigned'.
    - user_assigned_identity: (Optional) The user assigned identity ID when type is 'UserAssigned'. DEPENDENCY: User Assigned Identity resource ID.
  EOF
  type = object({
    type                   = string
    user_assigned_identity = optional(string)
  })
  default = null
}

variable "dead_letter_identity" {
  description = <<-EOF
    A dead_letter_identity block for managed identity dead lettering.
    - type: (Required) The type of managed identity. Possible values are 'SystemAssigned' or 'UserAssigned'.
    - user_assigned_identity: (Optional) The user assigned identity ID when type is 'UserAssigned'. DEPENDENCY: User Assigned Identity resource ID.
  EOF
  type = object({
    type                   = string
    user_assigned_identity = optional(string)
  })
  default = null
}

variable "storage_queue_endpoint" {
  description = <<-EOF
    A storage_queue_endpoint block for delivering events to an Azure Storage Queue.
    - storage_account_id: (Required) The ID of the Storage Account. DEPENDENCY: Storage Account resource ID.
    - queue_name: (Required) The name of the Storage Queue.
    - queue_message_time_to_live: (Optional) The message time to live in seconds.
  EOF
  type = object({
    storage_account_id          = string
    queue_name                  = string
    queue_message_time_to_live  = optional(number)
  })
  default = null
}

variable "webhook_endpoint" {
  description = <<-EOF
    A webhook_endpoint block for delivering events to a webhook.
    - url: (Required) The URL of the webhook endpoint.
    - max_events_per_batch: (Optional) Maximum number of events per batch. Defaults to 1.
    - preferred_batch_size_in_kilobytes: (Optional) Preferred batch size in kilobytes. Defaults to 64.
    - active_directory_tenant_id: (Optional) The Azure Active Directory Tenant ID for authentication.
    - active_directory_app_id_or_uri: (Optional) The Azure Active Directory Application ID or URI for authentication.
  EOF
  type = object({
    url                                 = string
    max_events_per_batch                = optional(number)
    preferred_batch_size_in_kilobytes   = optional(number)
    active_directory_tenant_id          = optional(string)
    active_directory_app_id_or_uri      = optional(string)
  })
  default = null
}

variable "azure_function_endpoint" {
  description = <<-EOF
    An azure_function_endpoint block for delivering events to an Azure Function.
    - function_id: (Required) The ID of the Azure Function. DEPENDENCY: Azure Function resource ID.
    - max_events_per_batch: (Optional) Maximum number of events per batch. Defaults to 1.
    - preferred_batch_size_in_kilobytes: (Optional) Preferred batch size in kilobytes. Defaults to 64.
  EOF
  type = object({
    function_id                         = string
    max_events_per_batch                = optional(number)
    preferred_batch_size_in_kilobytes   = optional(number)
  })
  default = null
}

variable "eventhub_endpoint_id" {
  description = "The ID of the Event Hub to deliver events to. DEPENDENCY: Event Hub resource ID."
  type        = string
  default     = null
}

variable "service_bus_queue_endpoint_id" {
  description = "The ID of the Service Bus Queue to deliver events to. DEPENDENCY: Service Bus Queue resource ID."
  type        = string
  default     = null
}

variable "service_bus_topic_endpoint_id" {
  description = "The ID of the Service Bus Topic to deliver events to. DEPENDENCY: Service Bus Topic resource ID."
  type        = string
  default     = null
}

variable "storage_blob_dead_letter_destination" {
  description = <<-EOF
    A storage_blob_dead_letter_destination block for dead letter events.
    - storage_account_id: (Required) The ID of the Storage Account. DEPENDENCY: Storage Account resource ID.
    - storage_blob_container_name: (Required) The name of the Storage Blob Container.
  EOF
  type = object({
    storage_account_id          = string
    storage_blob_container_name = string
  })
  default = null
}

variable "retry_policy" {
  description = <<-EOF
    A retry_policy block for configuring event delivery retry.
    - max_delivery_attempts: (Required) Maximum number of delivery retry attempts. Value must be between 1 and 30.
    - event_time_to_live: (Required) Event time to live in minutes. Value must be between 1 and 1440.
  EOF
  type = object({
    max_delivery_attempts = number
    event_time_to_live    = number
  })
  default = null
}

variable "labels" {
  description = "A list of labels to assign to the Event Grid Subscription."
  type        = list(string)
  default     = null
}

variable "advanced_filtering_on_arrays_enabled" {
  description = "Whether advanced filtering on arrays is enabled."
  type        = bool
  default     = false
}

variable "expiration_time_utc" {
  description = "The expiration time of the Event Grid Subscription in RFC 3339 format (e.g., '2024-12-31T23:59:59Z')."
  type        = string
  default     = null
}
