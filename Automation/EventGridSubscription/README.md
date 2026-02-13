# Azure Event Grid Subscription Terraform Module

This Terraform module creates an Azure Event Grid Subscription resource with support for multiple endpoint types, advanced filtering, dead letter destinations, and retry policies.

## Features

- Support for multiple endpoint types: Webhook, Azure Function, Event Hub, Service Bus Queue/Topic, Storage Queue
- Advanced event filtering with multiple filter operators
- Subject-based filtering
- Dead letter destination configuration
- Managed identity support for delivery and dead letter operations
- Retry policy configuration
- Conditional resource creation with `create` flag

## Usage

### Basic Webhook Subscription

```hcl
module "eventgrid_subscription" {
  source = "../"

  name  = "my-webhook-subscription"
  scope = azurerm_storage_account.example.id

  webhook_endpoint = {
    url = "https://myapp.azurewebsites.net/api/events"
  }

  included_event_types = [
    "Microsoft.Storage.BlobCreated",
    "Microsoft.Storage.BlobDeleted"
  ]
}
```

### Azure Function Endpoint

```hcl
module "eventgrid_subscription" {
  source = "../"

  name  = "function-subscription"
  scope = azurerm_storage_account.example.id

  azure_function_endpoint = {
    function_id                       = azurerm_function_app_function.example.id
    max_events_per_batch              = 10
    preferred_batch_size_in_kilobytes = 128
  }

  subject_filter = {
    subject_begins_with = "/blobServices/default/containers/mycontainer"
    case_sensitive      = false
  }
}
```

### Storage Queue Endpoint

```hcl
module "eventgrid_subscription" {
  source = "../"

  name  = "queue-subscription"
  scope = azurerm_resource_group.example.id

  storage_queue_endpoint = {
    storage_account_id         = azurerm_storage_account.example.id
    queue_name                 = "eventqueue"
    queue_message_time_to_live = 604800
  }

  retry_policy = {
    max_delivery_attempts = 30
    event_time_to_live    = 1440
  }
}
```

### Event Hub Endpoint

```hcl
module "eventgrid_subscription" {
  source = "../"

  name  = "eventhub-subscription"
  scope = azurerm_storage_account.example.id

  eventhub_endpoint_id = azurerm_eventhub.example.id

  delivery_identity = {
    type = "SystemAssigned"
  }

  storage_blob_dead_letter_destination = {
    storage_account_id          = azurerm_storage_account.deadletter.id
    storage_blob_container_name = "deadletters"
  }
}
```

### Advanced Filtering Example

```hcl
module "eventgrid_subscription" {
  source = "../"

  name  = "filtered-subscription"
  scope = azurerm_storage_account.example.id

  webhook_endpoint = {
    url                    = "https://myapp.azurewebsites.net/api/events"
    max_events_per_batch   = 10
    preferred_batch_size_in_kilobytes = 64
  }

  advanced_filtering_on_arrays_enabled = true

  advanced_filter = {
    string_contains = [
      {
        key    = "data.url"
        values = ["important", "critical"]
      }
    ]
    number_greater_than = [
      {
        key   = "data.size"
        value = 1024
      }
    ]
    string_ends_with = [
      {
        key    = "subject"
        values = [".jpg", ".png", ".gif"]
      }
    ]
  }

  labels = ["production", "images"]
}
```

### Service Bus Queue with User Assigned Identity

```hcl
module "eventgrid_subscription" {
  source = "../"

  name  = "servicebus-subscription"
  scope = azurerm_storage_account.example.id

  service_bus_queue_endpoint_id = azurerm_servicebus_queue.example.id

  delivery_identity = {
    type                   = "UserAssigned"
    user_assigned_identity = azurerm_user_assigned_identity.example.id
  }

  dead_letter_identity = {
    type                   = "UserAssigned"
    user_assigned_identity = azurerm_user_assigned_identity.example.id
  }

  storage_blob_dead_letter_destination = {
    storage_account_id          = azurerm_storage_account.deadletter.id
    storage_blob_container_name = "deadletters"
  }

  expiration_time_utc = "2025-12-31T23:59:59Z"
}
```

### Webhook with Azure AD Authentication

```hcl
module "eventgrid_subscription" {
  source = "../"

  name  = "secure-webhook-subscription"
  scope = azurerm_storage_account.example.id

  webhook_endpoint = {
    url                            = "https://myapp.azurewebsites.net/api/events"
    active_directory_tenant_id     = data.azurerm_client_config.current.tenant_id
    active_directory_app_id_or_uri = azuread_application.example.application_id
  }

  event_delivery_schema = "CloudEventSchemaV1_0"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_eventgrid_event_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_event_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the Event Grid Subscription resource. | `bool` | `true` | no |
| name | The name of the Event Grid Subscription. | `string` | n/a | yes |
| scope | The resource ID to subscribe to events from. DEPENDENCY. | `string` | n/a | yes |
| event_delivery_schema | The schema for incoming events. Possible values: 'EventGridSchema', 'CloudEventSchemaV1_0', 'CustomInputSchema'. | `string` | `"EventGridSchema"` | no |
| included_event_types | A list of event types to include. | `list(string)` | `null` | no |
| subject_filter | Subject filter configuration block. | `object` | `null` | no |
| advanced_filter | Advanced filter configuration block with multiple filter types. | `object` | `null` | no |
| delivery_identity | Managed identity configuration for event delivery. | `object` | `null` | no |
| dead_letter_identity | Managed identity configuration for dead letter operations. | `object` | `null` | no |
| storage_queue_endpoint | Storage Queue endpoint configuration. DEPENDENCY on Storage Account. | `object` | `null` | no |
| webhook_endpoint | Webhook endpoint configuration. | `object` | `null` | no |
| azure_function_endpoint | Azure Function endpoint configuration. DEPENDENCY on Function. | `object` | `null` | no |
| eventhub_endpoint_id | Event Hub endpoint ID. DEPENDENCY. | `string` | `null` | no |
| service_bus_queue_endpoint_id | Service Bus Queue endpoint ID. DEPENDENCY. | `string` | `null` | no |
| service_bus_topic_endpoint_id | Service Bus Topic endpoint ID. DEPENDENCY. | `string` | `null` | no |
| storage_blob_dead_letter_destination | Dead letter destination configuration. DEPENDENCY on Storage Account. | `object` | `null` | no |
| retry_policy | Retry policy configuration block. | `object` | `null` | no |
| labels | A list of labels to assign to the subscription. | `list(string)` | `null` | no |
| advanced_filtering_on_arrays_enabled | Whether advanced filtering on arrays is enabled. | `bool` | `false` | no |
| expiration_time_utc | Expiration time in RFC 3339 format. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Event Grid Subscription. |
| name | The name of the Event Grid Subscription. |

## Event Delivery Schemas

- **EventGridSchema**: Default Event Grid schema
- **CloudEventSchemaV1_0**: Cloud Events v1.0 schema
- **CustomInputSchema**: Custom schema (requires input mapping)

## Endpoint Types

Only one endpoint type can be specified per subscription:

1. **webhook_endpoint**: HTTP/HTTPS webhook
2. **azure_function_endpoint**: Azure Function
3. **storage_queue_endpoint**: Azure Storage Queue
4. **eventhub_endpoint_id**: Azure Event Hub
5. **service_bus_queue_endpoint_id**: Azure Service Bus Queue
6. **service_bus_topic_endpoint_id**: Azure Service Bus Topic

## Advanced Filter Operators

The module supports all Event Grid advanced filter operators:

- Boolean: `bool_equals`
- Numeric: `number_greater_than`, `number_greater_than_or_equals`, `number_less_than`, `number_less_than_or_equals`, `number_in`, `number_not_in`, `number_in_range`, `number_not_in_range`
- String: `string_begins_with`, `string_ends_with`, `string_contains`, `string_in`, `string_not_in`, `string_not_begins_with`, `string_not_ends_with`, `string_not_contains`
- Null checks: `is_not_null`, `is_null_or_undefined`

## License

MIT License
