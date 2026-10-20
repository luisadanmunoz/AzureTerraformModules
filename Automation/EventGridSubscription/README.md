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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_eventgrid_event_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_event_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_advanced_filter"></a> [advanced\_filter](#input\_advanced\_filter) | An advanced\_filter block for advanced event filtering. Supports the following filter types:<br/>- bool\_equals: (Optional) List of objects with key and value.<br/>- number\_greater\_than: (Optional) List of objects with key and value.<br/>- number\_greater\_than\_or\_equals: (Optional) List of objects with key and value.<br/>- number\_less\_than: (Optional) List of objects with key and value.<br/>- number\_less\_than\_or\_equals: (Optional) List of objects with key and value.<br/>- number\_in: (Optional) List of objects with key and values.<br/>- number\_not\_in: (Optional) List of objects with key and values.<br/>- number\_in\_range: (Optional) List of objects with key and values.<br/>- number\_not\_in\_range: (Optional) List of objects with key and values.<br/>- string\_begins\_with: (Optional) List of objects with key and values.<br/>- string\_ends\_with: (Optional) List of objects with key and values.<br/>- string\_contains: (Optional) List of objects with key and values.<br/>- string\_in: (Optional) List of objects with key and values.<br/>- string\_not\_in: (Optional) List of objects with key and values.<br/>- string\_not\_begins\_with: (Optional) List of objects with key and values.<br/>- string\_not\_ends\_with: (Optional) List of objects with key and values.<br/>- string\_not\_contains: (Optional) List of objects with key and values.<br/>- is\_not\_null: (Optional) List of objects with key.<br/>- is\_null\_or\_undefined: (Optional) List of objects with key. | <pre>object({<br/>    bool_equals                     = optional(list(object({ key = string, value = bool })))<br/>    number_greater_than             = optional(list(object({ key = string, value = number })))<br/>    number_greater_than_or_equals   = optional(list(object({ key = string, value = number })))<br/>    number_less_than                = optional(list(object({ key = string, value = number })))<br/>    number_less_than_or_equals      = optional(list(object({ key = string, value = number })))<br/>    number_in                       = optional(list(object({ key = string, values = list(number) })))<br/>    number_not_in                   = optional(list(object({ key = string, values = list(number) })))<br/>    number_in_range                 = optional(list(object({ key = string, values = list(list(number)) })))<br/>    number_not_in_range             = optional(list(object({ key = string, values = list(list(number)) })))<br/>    string_begins_with              = optional(list(object({ key = string, values = list(string) })))<br/>    string_ends_with                = optional(list(object({ key = string, values = list(string) })))<br/>    string_contains                 = optional(list(object({ key = string, values = list(string) })))<br/>    string_in                       = optional(list(object({ key = string, values = list(string) })))<br/>    string_not_in                   = optional(list(object({ key = string, values = list(string) })))<br/>    string_not_begins_with          = optional(list(object({ key = string, values = list(string) })))<br/>    string_not_ends_with            = optional(list(object({ key = string, values = list(string) })))<br/>    string_not_contains             = optional(list(object({ key = string, values = list(string) })))<br/>    is_not_null                     = optional(list(object({ key = string })))<br/>    is_null_or_undefined            = optional(list(object({ key = string })))<br/>  })</pre> | `null` | no |
| <a name="input_advanced_filtering_on_arrays_enabled"></a> [advanced\_filtering\_on\_arrays\_enabled](#input\_advanced\_filtering\_on\_arrays\_enabled) | Whether advanced filtering on arrays is enabled. | `bool` | `false` | no |
| <a name="input_azure_function_endpoint"></a> [azure\_function\_endpoint](#input\_azure\_function\_endpoint) | An azure\_function\_endpoint block for delivering events to an Azure Function.<br/>- function\_id: (Required) The ID of the Azure Function. DEPENDENCY: Azure Function resource ID.<br/>- max\_events\_per\_batch: (Optional) Maximum number of events per batch. Defaults to 1.<br/>- preferred\_batch\_size\_in\_kilobytes: (Optional) Preferred batch size in kilobytes. Defaults to 64. | <pre>object({<br/>    function_id                         = string<br/>    max_events_per_batch                = optional(number)<br/>    preferred_batch_size_in_kilobytes   = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Event Grid Subscription resource. | `bool` | `true` | no |
| <a name="input_dead_letter_identity"></a> [dead\_letter\_identity](#input\_dead\_letter\_identity) | A dead\_letter\_identity block for managed identity dead lettering.<br/>- type: (Required) The type of managed identity. Possible values are 'SystemAssigned' or 'UserAssigned'.<br/>- user\_assigned\_identity: (Optional) The user assigned identity ID when type is 'UserAssigned'. DEPENDENCY: User Assigned Identity resource ID. | <pre>object({<br/>    type                   = string<br/>    user_assigned_identity = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_delivery_identity"></a> [delivery\_identity](#input\_delivery\_identity) | A delivery\_identity block for managed identity delivery.<br/>- type: (Required) The type of managed identity. Possible values are 'SystemAssigned' or 'UserAssigned'.<br/>- user\_assigned\_identity: (Optional) The user assigned identity ID when type is 'UserAssigned'. DEPENDENCY: User Assigned Identity resource ID. | <pre>object({<br/>    type                   = string<br/>    user_assigned_identity = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_event_delivery_schema"></a> [event\_delivery\_schema](#input\_event\_delivery\_schema) | The schema in which incoming events will be delivered. Possible values are 'EventGridSchema', 'CloudEventSchemaV1\_0', or 'CustomInputSchema'. | `string` | `"EventGridSchema"` | no |
| <a name="input_eventhub_endpoint_id"></a> [eventhub\_endpoint\_id](#input\_eventhub\_endpoint\_id) | The ID of the Event Hub to deliver events to. DEPENDENCY: Event Hub resource ID. | `string` | `null` | no |
| <a name="input_expiration_time_utc"></a> [expiration\_time\_utc](#input\_expiration\_time\_utc) | The expiration time of the Event Grid Subscription in RFC 3339 format (e.g., '2024-12-31T23:59:59Z'). | `string` | `null` | no |
| <a name="input_included_event_types"></a> [included\_event\_types](#input\_included\_event\_types) | A list of event types to include. If not specified, all event types will be included. | `list(string)` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A list of labels to assign to the Event Grid Subscription. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Event Grid Subscription. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_retry_policy"></a> [retry\_policy](#input\_retry\_policy) | A retry\_policy block for configuring event delivery retry.<br/>- max\_delivery\_attempts: (Required) Maximum number of delivery retry attempts. Value must be between 1 and 30.<br/>- event\_time\_to\_live: (Required) Event time to live in minutes. Value must be between 1 and 1440. | <pre>object({<br/>    max_delivery_attempts = number<br/>    event_time_to_live    = number<br/>  })</pre> | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | The resource ID to subscribe to events from. DEPENDENCY: The ID of the resource to subscribe to (e.g., Storage Account, Resource Group, Azure Subscription). | `string` | n/a | yes |
| <a name="input_service_bus_queue_endpoint_id"></a> [service\_bus\_queue\_endpoint\_id](#input\_service\_bus\_queue\_endpoint\_id) | The ID of the Service Bus Queue to deliver events to. DEPENDENCY: Service Bus Queue resource ID. | `string` | `null` | no |
| <a name="input_service_bus_topic_endpoint_id"></a> [service\_bus\_topic\_endpoint\_id](#input\_service\_bus\_topic\_endpoint\_id) | The ID of the Service Bus Topic to deliver events to. DEPENDENCY: Service Bus Topic resource ID. | `string` | `null` | no |
| <a name="input_storage_blob_dead_letter_destination"></a> [storage\_blob\_dead\_letter\_destination](#input\_storage\_blob\_dead\_letter\_destination) | A storage\_blob\_dead\_letter\_destination block for dead letter events.<br/>- storage\_account\_id: (Required) The ID of the Storage Account. DEPENDENCY: Storage Account resource ID.<br/>- storage\_blob\_container\_name: (Required) The name of the Storage Blob Container. | <pre>object({<br/>    storage_account_id          = string<br/>    storage_blob_container_name = string<br/>  })</pre> | `null` | no |
| <a name="input_storage_queue_endpoint"></a> [storage\_queue\_endpoint](#input\_storage\_queue\_endpoint) | A storage\_queue\_endpoint block for delivering events to an Azure Storage Queue.<br/>- storage\_account\_id: (Required) The ID of the Storage Account. DEPENDENCY: Storage Account resource ID.<br/>- queue\_name: (Required) The name of the Storage Queue.<br/>- queue\_message\_time\_to\_live: (Optional) The message time to live in seconds. | <pre>object({<br/>    storage_account_id          = string<br/>    queue_name                  = string<br/>    queue_message_time_to_live  = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_subject_filter"></a> [subject\_filter](#input\_subject\_filter) | A subject\_filter block for filtering events by subject.<br/>- subject\_begins\_with: (Optional) A string that the subject must begin with.<br/>- subject\_ends\_with: (Optional) A string that the subject must end with.<br/>- case\_sensitive: (Optional) Whether the subject is case sensitive. Defaults to false. | <pre>object({<br/>    subject_begins_with = optional(string)<br/>    subject_ends_with   = optional(string)<br/>    case_sensitive      = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_webhook_endpoint"></a> [webhook\_endpoint](#input\_webhook\_endpoint) | A webhook\_endpoint block for delivering events to a webhook.<br/>- url: (Required) The URL of the webhook endpoint.<br/>- max\_events\_per\_batch: (Optional) Maximum number of events per batch. Defaults to 1.<br/>- preferred\_batch\_size\_in\_kilobytes: (Optional) Preferred batch size in kilobytes. Defaults to 64.<br/>- active\_directory\_tenant\_id: (Optional) The Azure Active Directory Tenant ID for authentication.<br/>- active\_directory\_app\_id\_or\_uri: (Optional) The Azure Active Directory Application ID or URI for authentication. | <pre>object({<br/>    url                                 = string<br/>    max_events_per_batch                = optional(number)<br/>    preferred_batch_size_in_kilobytes   = optional(number)<br/>    active_directory_tenant_id          = optional(string)<br/>    active_directory_app_id_or_uri      = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Event Grid Subscription. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Event Grid Subscription. |
<!-- END_TF_DOCS -->