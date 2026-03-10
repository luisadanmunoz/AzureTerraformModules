resource "azurerm_eventgrid_event_subscription" "this" {
  count = local.create ? 1 : 0

  name  = var.name
  scope = var.scope

  event_delivery_schema                = var.event_delivery_schema
  included_event_types                 = var.included_event_types
  labels                               = var.labels
  advanced_filtering_on_arrays_enabled = var.advanced_filtering_on_arrays_enabled
  expiration_time_utc                  = var.expiration_time_utc

  # Direct endpoint IDs
  # DEPENDENCY: Event Hub resource ID
  eventhub_endpoint_id = var.eventhub_endpoint_id
  # DEPENDENCY: Service Bus Queue resource ID
  service_bus_queue_endpoint_id = var.service_bus_queue_endpoint_id
  # DEPENDENCY: Service Bus Topic resource ID
  service_bus_topic_endpoint_id = var.service_bus_topic_endpoint_id

  # Subject filter block
  dynamic "subject_filter" {
    for_each = var.subject_filter != null ? [var.subject_filter] : []
    content {
      subject_begins_with = subject_filter.value.subject_begins_with
      subject_ends_with   = subject_filter.value.subject_ends_with
      case_sensitive      = subject_filter.value.case_sensitive
    }
  }

  # Advanced filter block
  dynamic "advanced_filter" {
    for_each = var.advanced_filter != null ? [var.advanced_filter] : []
    content {
      dynamic "bool_equals" {
        for_each = advanced_filter.value.bool_equals != null ? advanced_filter.value.bool_equals : []
        content {
          key   = bool_equals.value.key
          value = bool_equals.value.value
        }
      }

      dynamic "number_greater_than" {
        for_each = advanced_filter.value.number_greater_than != null ? advanced_filter.value.number_greater_than : []
        content {
          key   = number_greater_than.value.key
          value = number_greater_than.value.value
        }
      }

      dynamic "number_greater_than_or_equals" {
        for_each = advanced_filter.value.number_greater_than_or_equals != null ? advanced_filter.value.number_greater_than_or_equals : []
        content {
          key   = number_greater_than_or_equals.value.key
          value = number_greater_than_or_equals.value.value
        }
      }

      dynamic "number_less_than" {
        for_each = advanced_filter.value.number_less_than != null ? advanced_filter.value.number_less_than : []
        content {
          key   = number_less_than.value.key
          value = number_less_than.value.value
        }
      }

      dynamic "number_less_than_or_equals" {
        for_each = advanced_filter.value.number_less_than_or_equals != null ? advanced_filter.value.number_less_than_or_equals : []
        content {
          key   = number_less_than_or_equals.value.key
          value = number_less_than_or_equals.value.value
        }
      }

      dynamic "number_in" {
        for_each = advanced_filter.value.number_in != null ? advanced_filter.value.number_in : []
        content {
          key    = number_in.value.key
          values = number_in.value.values
        }
      }

      dynamic "number_not_in" {
        for_each = advanced_filter.value.number_not_in != null ? advanced_filter.value.number_not_in : []
        content {
          key    = number_not_in.value.key
          values = number_not_in.value.values
        }
      }

      dynamic "number_in_range" {
        for_each = advanced_filter.value.number_in_range != null ? advanced_filter.value.number_in_range : []
        content {
          key    = number_in_range.value.key
          values = number_in_range.value.values
        }
      }

      dynamic "number_not_in_range" {
        for_each = advanced_filter.value.number_not_in_range != null ? advanced_filter.value.number_not_in_range : []
        content {
          key    = number_not_in_range.value.key
          values = number_not_in_range.value.values
        }
      }

      dynamic "string_begins_with" {
        for_each = advanced_filter.value.string_begins_with != null ? advanced_filter.value.string_begins_with : []
        content {
          key    = string_begins_with.value.key
          values = string_begins_with.value.values
        }
      }

      dynamic "string_ends_with" {
        for_each = advanced_filter.value.string_ends_with != null ? advanced_filter.value.string_ends_with : []
        content {
          key    = string_ends_with.value.key
          values = string_ends_with.value.values
        }
      }

      dynamic "string_contains" {
        for_each = advanced_filter.value.string_contains != null ? advanced_filter.value.string_contains : []
        content {
          key    = string_contains.value.key
          values = string_contains.value.values
        }
      }

      dynamic "string_in" {
        for_each = advanced_filter.value.string_in != null ? advanced_filter.value.string_in : []
        content {
          key    = string_in.value.key
          values = string_in.value.values
        }
      }

      dynamic "string_not_in" {
        for_each = advanced_filter.value.string_not_in != null ? advanced_filter.value.string_not_in : []
        content {
          key    = string_not_in.value.key
          values = string_not_in.value.values
        }
      }

      dynamic "string_not_begins_with" {
        for_each = advanced_filter.value.string_not_begins_with != null ? advanced_filter.value.string_not_begins_with : []
        content {
          key    = string_not_begins_with.value.key
          values = string_not_begins_with.value.values
        }
      }

      dynamic "string_not_ends_with" {
        for_each = advanced_filter.value.string_not_ends_with != null ? advanced_filter.value.string_not_ends_with : []
        content {
          key    = string_not_ends_with.value.key
          values = string_not_ends_with.value.values
        }
      }

      dynamic "string_not_contains" {
        for_each = advanced_filter.value.string_not_contains != null ? advanced_filter.value.string_not_contains : []
        content {
          key    = string_not_contains.value.key
          values = string_not_contains.value.values
        }
      }

      dynamic "is_not_null" {
        for_each = advanced_filter.value.is_not_null != null ? advanced_filter.value.is_not_null : []
        content {
          key = is_not_null.value.key
        }
      }

      dynamic "is_null_or_undefined" {
        for_each = advanced_filter.value.is_null_or_undefined != null ? advanced_filter.value.is_null_or_undefined : []
        content {
          key = is_null_or_undefined.value.key
        }
      }
    }
  }

  # Delivery identity block
  dynamic "delivery_identity" {
    for_each = var.delivery_identity != null ? [var.delivery_identity] : []
    content {
      type = delivery_identity.value.type
      # DEPENDENCY: User Assigned Identity resource ID
      user_assigned_identity = delivery_identity.value.user_assigned_identity
    }
  }

  # Dead letter identity block
  dynamic "dead_letter_identity" {
    for_each = var.dead_letter_identity != null ? [var.dead_letter_identity] : []
    content {
      type = dead_letter_identity.value.type
      # DEPENDENCY: User Assigned Identity resource ID
      user_assigned_identity = dead_letter_identity.value.user_assigned_identity
    }
  }

  # Storage queue endpoint block
  dynamic "storage_queue_endpoint" {
    for_each = var.storage_queue_endpoint != null ? [var.storage_queue_endpoint] : []
    content {
      # DEPENDENCY: Storage Account resource ID
      storage_account_id         = storage_queue_endpoint.value.storage_account_id
      queue_name                 = storage_queue_endpoint.value.queue_name
      queue_message_time_to_live = storage_queue_endpoint.value.queue_message_time_to_live
    }
  }

  # Webhook endpoint block
  dynamic "webhook_endpoint" {
    for_each = var.webhook_endpoint != null ? [var.webhook_endpoint] : []
    content {
      url                               = webhook_endpoint.value.url
      max_events_per_batch              = webhook_endpoint.value.max_events_per_batch
      preferred_batch_size_in_kilobytes = webhook_endpoint.value.preferred_batch_size_in_kilobytes
      active_directory_tenant_id        = webhook_endpoint.value.active_directory_tenant_id
      active_directory_app_id_or_uri    = webhook_endpoint.value.active_directory_app_id_or_uri
    }
  }

  # Azure function endpoint block
  dynamic "azure_function_endpoint" {
    for_each = var.azure_function_endpoint != null ? [var.azure_function_endpoint] : []
    content {
      # DEPENDENCY: Azure Function resource ID
      function_id                       = azure_function_endpoint.value.function_id
      max_events_per_batch              = azure_function_endpoint.value.max_events_per_batch
      preferred_batch_size_in_kilobytes = azure_function_endpoint.value.preferred_batch_size_in_kilobytes
    }
  }

  # Storage blob dead letter destination block
  dynamic "storage_blob_dead_letter_destination" {
    for_each = var.storage_blob_dead_letter_destination != null ? [var.storage_blob_dead_letter_destination] : []
    content {
      # DEPENDENCY: Storage Account resource ID
      storage_account_id          = storage_blob_dead_letter_destination.value.storage_account_id
      storage_blob_container_name = storage_blob_dead_letter_destination.value.storage_blob_container_name
    }
  }

  # Retry policy block
  dynamic "retry_policy" {
    for_each = var.retry_policy != null ? [var.retry_policy] : []
    content {
      max_delivery_attempts = retry_policy.value.max_delivery_attempts
      event_time_to_live    = retry_policy.value.event_time_to_live
    }
  }
}
