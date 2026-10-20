# Azure Event Grid System Topic Terraform Module

This Terraform module creates an Azure Event Grid System Topic with optional event subscriptions. Event Grid System Topics are automatically created topics that represent events from Azure services like Storage Accounts, Resource Groups, Event Hubs, and more.

## Features

- Create Event Grid System Topics for various Azure resource types
- Configure managed identity (System Assigned, User Assigned, or both)
- Create multiple event subscriptions with various endpoint types
- Support for webhook, storage queue, Event Hub, Service Bus, and Azure Function endpoints
- Advanced filtering capabilities
- Dead letter destination configuration
- Retry policy configuration
- Flexible naming convention support

## Usage

### Basic Example - Storage Account System Topic

```hcl
module "eventgrid_system_topic" {
  source = "path/to/modules/Automation/EventGridSystemTopic"

  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  source_arm_resource_id = azurerm_storage_account.example.id
  topic_type             = "Microsoft.Storage.StorageAccounts"

  workload    = "storage"
  environment = "prod"
  instance    = "001"

  event_subscriptions = {
    "blob-created-webhook" = {
      included_event_types = ["Microsoft.Storage.BlobCreated"]
      webhook_endpoint = {
        url = "https://example.com/api/events"
      }
    }
  }

  tags = {
    Environment = "Production"
    Project     = "EventProcessing"
  }
}
```

### Resource Group System Topic

```hcl
module "rg_system_topic" {
  source = "path/to/modules/Automation/EventGridSystemTopic"

  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  source_arm_resource_id = azurerm_resource_group.monitored.id
  topic_type             = "Microsoft.Resources.ResourceGroups"

  name = "rg-events-topic"

  identity = {
    type = "SystemAssigned"
  }

  event_subscriptions = {
    "resource-changes" = {
      included_event_types = [
        "Microsoft.Resources.ResourceWriteSuccess",
        "Microsoft.Resources.ResourceDeleteSuccess"
      ]
      eventhub_endpoint_id = azurerm_eventhub.example.id
      retry_policy = {
        max_delivery_attempts = 10
        event_time_to_live    = 1440
      }
    }
  }

  tags = {
    Environment = "Production"
  }
}
```

### Event Hub Namespace System Topic

```hcl
module "eventhub_system_topic" {
  source = "path/to/modules/Automation/EventGridSystemTopic"

  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  source_arm_resource_id = azurerm_eventhub_namespace.example.id
  topic_type             = "Microsoft.EventHub.Namespaces"

  workload    = "eventhub"
  environment = "dev"

  event_subscriptions = {
    "capture-events" = {
      included_event_types = ["Microsoft.EventHub.CaptureFileCreated"]
      storage_queue_endpoint = {
        storage_account_id = azurerm_storage_account.example.id
        queue_name         = "eventhub-capture-events"
      }
    }
  }
}
```

### Storage Account with Advanced Filtering

```hcl
module "storage_system_topic" {
  source = "path/to/modules/Automation/EventGridSystemTopic"

  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  source_arm_resource_id = azurerm_storage_account.example.id
  topic_type             = "Microsoft.Storage.StorageAccounts"

  name = "storage-events-topic"

  event_subscriptions = {
    "json-files-only" = {
      included_event_types = ["Microsoft.Storage.BlobCreated"]

      subject_filter = {
        subject_begins_with = "/blobServices/default/containers/uploads/"
        subject_ends_with   = ".json"
        case_sensitive      = false
      }

      advanced_filter = {
        number_greater_than = [
          {
            key   = "data.contentLength"
            value = 0
          }
        ]
        string_contains = [
          {
            key    = "data.url"
            values = ["important", "priority"]
          }
        ]
      }

      azure_function_endpoint = {
        function_id = azurerm_function_app_function.process_json.id
      }

      storage_blob_dead_letter_destination = {
        storage_account_id          = azurerm_storage_account.deadletter.id
        storage_blob_container_name = "deadletter"
      }
    }
  }

  tags = {
    Environment = "Production"
    Purpose     = "FileProcessing"
  }
}
```

### With User Assigned Identity

```hcl
module "system_topic_with_identity" {
  source = "path/to/modules/Automation/EventGridSystemTopic"

  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  source_arm_resource_id = azurerm_storage_account.example.id
  topic_type             = "Microsoft.Storage.StorageAccounts"

  workload    = "storage"
  environment = "prod"

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }

  event_subscriptions = {
    "blob-events" = {
      included_event_types = ["Microsoft.Storage.BlobCreated", "Microsoft.Storage.BlobDeleted"]
      service_bus_queue_endpoint_id = azurerm_servicebus_queue.example.id
    }
  }
}
```

## Supported Topic Types

| Topic Type | Description |
|------------|-------------|
| `Microsoft.Storage.StorageAccounts` | Azure Storage Account events (blob, file, queue, table) |
| `Microsoft.Resources.ResourceGroups` | Resource Group events (resource changes) |
| `Microsoft.EventHub.Namespaces` | Event Hub Namespace events |
| `Microsoft.ServiceBus.Namespaces` | Service Bus Namespace events |
| `Microsoft.ContainerRegistry.Registries` | Container Registry events |
| `Microsoft.Devices.IoTHubs` | IoT Hub events |
| `Microsoft.Maps.Accounts` | Azure Maps events |
| `Microsoft.Media.MediaServices` | Media Services events |
| `Microsoft.Communication.CommunicationServices` | Communication Services events |
| `Microsoft.Web.Sites` | App Service (Web Apps) events |
| `Microsoft.Web.ServerFarms` | App Service Plan events |
| `Microsoft.KeyVault.vaults` | Key Vault events |
| `Microsoft.SignalRService.SignalR` | SignalR Service events |
| `Microsoft.MachineLearningServices.Workspaces` | Machine Learning Workspace events |

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
| [azurerm_eventgrid_system_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) | resource |
| [azurerm_eventgrid_system_topic_event_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic_event_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | The name of the resource group in which to create the Event Grid System Topic. | `string` | n/a | yes |
| location | The Azure region where the Event Grid System Topic will be created. | `string` | n/a | yes |
| source_arm_resource_id | The ARM resource ID of the source resource. | `string` | n/a | yes |
| topic_type | The type of the source resource. | `string` | n/a | yes |
| name | The exact name of the Event Grid System Topic. | `string` | `null` | no |
| name_prefix | Prefix to use for the generated name. | `string` | `"evgst"` | no |
| workload | The workload name to include in the generated name. | `string` | `null` | no |
| environment | The environment name to include in the generated name. | `string` | `null` | no |
| instance | The instance identifier to include in the generated name. | `string` | `null` | no |
| create | Whether to create the Event Grid System Topic resource. | `bool` | `true` | no |
| identity | Identity configuration for the Event Grid System Topic. | `object` | `null` | no |
| event_subscriptions | A map of event subscriptions to create for this system topic. | `map(object)` | `{}` | no |
| tags | A map of tags to assign to the Event Grid System Topic. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Event Grid System Topic. |
| name | The name of the Event Grid System Topic. |
| metric_arm_resource_id | The Metric ARM Resource ID of the Event Grid System Topic. |
| principal_id | The Principal ID of the System Assigned Managed Identity. |
| tenant_id | The Tenant ID of the System Assigned Managed Identity. |
| event_subscription_ids | A map of event subscription names to their IDs. |
| resource | The full Event Grid System Topic resource object. |
| event_subscriptions | A map of event subscription names to their full resource objects. |

## Event Subscription Endpoint Types

The module supports the following endpoint types for event subscriptions:

1. **Webhook Endpoint** - HTTP/HTTPS endpoints that receive events
2. **Storage Queue Endpoint** - Azure Storage Queue for queuing events
3. **Event Hub Endpoint** - Azure Event Hub for streaming events
4. **Service Bus Queue Endpoint** - Azure Service Bus Queue
5. **Service Bus Topic Endpoint** - Azure Service Bus Topic
6. **Azure Function Endpoint** - Direct integration with Azure Functions

## Notes

- Only one source resource can be associated with a system topic
- The source resource must exist before creating the system topic
- Event subscriptions are created after the system topic is provisioned
- When using managed identity, ensure proper RBAC permissions are configured for the destination endpoints

## License

This module is licensed under the MIT License.

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
| [azurerm_eventgrid_system_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) | resource |
| [azurerm_eventgrid_system_topic_event_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic_event_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Event Grid System Topic resource. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name to include in the generated name (e.g., dev, staging, prod). | `string` | `null` | no |
| <a name="input_event_subscriptions"></a> [event\_subscriptions](#input\_event\_subscriptions) | A map of event subscriptions to create for this system topic.<br/>Each subscription can have the following attributes:<br/>- event\_delivery\_schema: The event delivery schema. Possible values are 'EventGridSchema', 'CloudEventSchemaV1\_0', 'CustomInputSchema'. Default: 'EventGridSchema'.<br/>- included\_event\_types: A list of event types to include. If not specified, all event types are included.<br/>- subject\_filter: An object with optional 'subject\_begins\_with' and 'subject\_ends\_with' strings, and 'case\_sensitive' boolean.<br/>- advanced\_filter: An object with filter configurations.<br/>- expiration\_time\_utc: The expiration time of the subscription in UTC.<br/>- labels: A list of labels for the subscription.<br/>- advanced\_filtering\_on\_arrays\_enabled: Whether advanced filtering on arrays is enabled.<br/><br/>Endpoint configuration (specify one):<br/>- webhook\_endpoint: Object with 'url', optional 'max\_events\_per\_batch', 'preferred\_batch\_size\_in\_kilobytes', 'active\_directory\_tenant\_id', 'active\_directory\_app\_id\_or\_uri'.<br/>- storage\_queue\_endpoint: Object with 'storage\_account\_id' and 'queue\_name', optional 'queue\_message\_time\_to\_live\_in\_seconds'.<br/>- eventhub\_endpoint\_id: The resource ID of an Event Hub to deliver events to.<br/>- service\_bus\_queue\_endpoint\_id: The resource ID of a Service Bus Queue to deliver events to.<br/>- service\_bus\_topic\_endpoint\_id: The resource ID of a Service Bus Topic to deliver events to.<br/>- azure\_function\_endpoint: Object with 'function\_id', optional 'max\_events\_per\_batch', 'preferred\_batch\_size\_in\_kilobytes'.<br/><br/>Retry and dead letter configuration:<br/>- retry\_policy: Object with 'max\_delivery\_attempts' (1-30) and 'event\_time\_to\_live' (1-1440 minutes).<br/>- storage\_blob\_dead\_letter\_destination: Object with 'storage\_account\_id' and 'storage\_blob\_container\_name'. | <pre>map(object({<br/>    event_delivery_schema                 = optional(string, "EventGridSchema")<br/>    included_event_types                  = optional(list(string))<br/>    expiration_time_utc                   = optional(string)<br/>    labels                                = optional(list(string))<br/>    advanced_filtering_on_arrays_enabled  = optional(bool, false)<br/><br/>    subject_filter = optional(object({<br/>      subject_begins_with = optional(string)<br/>      subject_ends_with   = optional(string)<br/>      case_sensitive      = optional(bool, false)<br/>    }))<br/><br/>    advanced_filter = optional(object({<br/>      bool_equals = optional(list(object({<br/>        key   = string<br/>        value = bool<br/>      })), [])<br/>      number_greater_than = optional(list(object({<br/>        key   = string<br/>        value = number<br/>      })), [])<br/>      number_greater_than_or_equals = optional(list(object({<br/>        key   = string<br/>        value = number<br/>      })), [])<br/>      number_less_than = optional(list(object({<br/>        key   = string<br/>        value = number<br/>      })), [])<br/>      number_less_than_or_equals = optional(list(object({<br/>        key   = string<br/>        value = number<br/>      })), [])<br/>      number_in = optional(list(object({<br/>        key    = string<br/>        values = list(number)<br/>      })), [])<br/>      number_not_in = optional(list(object({<br/>        key    = string<br/>        values = list(number)<br/>      })), [])<br/>      number_in_range = optional(list(object({<br/>        key    = string<br/>        values = list(list(number))<br/>      })), [])<br/>      number_not_in_range = optional(list(object({<br/>        key    = string<br/>        values = list(list(number))<br/>      })), [])<br/>      string_begins_with = optional(list(object({<br/>        key    = string<br/>        values = list(string)<br/>      })), [])<br/>      string_ends_with = optional(list(object({<br/>        key    = string<br/>        values = list(string)<br/>      })), [])<br/>      string_contains = optional(list(object({<br/>        key    = string<br/>        values = list(string)<br/>      })), [])<br/>      string_not_begins_with = optional(list(object({<br/>        key    = string<br/>        values = list(string)<br/>      })), [])<br/>      string_not_ends_with = optional(list(object({<br/>        key    = string<br/>        values = list(string)<br/>      })), [])<br/>      string_not_contains = optional(list(object({<br/>        key    = string<br/>        values = list(string)<br/>      })), [])<br/>      string_in = optional(list(object({<br/>        key    = string<br/>        values = list(string)<br/>      })), [])<br/>      string_not_in = optional(list(object({<br/>        key    = string<br/>        values = list(string)<br/>      })), [])<br/>      is_null_or_undefined = optional(list(object({<br/>        key = string<br/>      })), [])<br/>      is_not_null = optional(list(object({<br/>        key = string<br/>      })), [])<br/>    }))<br/><br/>    webhook_endpoint = optional(object({<br/>      url                               = string<br/>      max_events_per_batch              = optional(number)<br/>      preferred_batch_size_in_kilobytes = optional(number)<br/>      active_directory_tenant_id        = optional(string)<br/>      active_directory_app_id_or_uri    = optional(string)<br/>    }))<br/><br/>    storage_queue_endpoint = optional(object({<br/>      storage_account_id                    = string<br/>      queue_name                            = string<br/>      queue_message_time_to_live_in_seconds = optional(number)<br/>    }))<br/><br/>    eventhub_endpoint_id           = optional(string)<br/>    service_bus_queue_endpoint_id  = optional(string)<br/>    service_bus_topic_endpoint_id  = optional(string)<br/><br/>    azure_function_endpoint = optional(object({<br/>      function_id                       = string<br/>      max_events_per_batch              = optional(number)<br/>      preferred_batch_size_in_kilobytes = optional(number)<br/>    }))<br/><br/>    retry_policy = optional(object({<br/>      max_delivery_attempts = optional(number, 30)<br/>      event_time_to_live    = optional(number, 1440)<br/>    }))<br/><br/>    storage_blob_dead_letter_destination = optional(object({<br/>      storage_account_id          = string<br/>      storage_blob_container_name = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Identity configuration for the Event Grid System Topic.<br/>- type: The type of identity. Possible values are 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'.<br/>- identity\_ids: A list of User Assigned Identity IDs to assign. Required when type includes 'UserAssigned'. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier to include in the generated name. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Event Grid System Topic will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The exact name of the Event Grid System Topic. If provided, overrides the generated name from name\_prefix/workload/environment/instance. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix to use for the generated name. Default is 'evgst' (Event Grid System Topic). | `string` | `"evgst"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Event Grid System Topic. DEPENDENCY: Resource group must exist. | `string` | n/a | yes |
| <a name="input_source_arm_resource_id"></a> [source\_arm\_resource\_id](#input\_source\_arm\_resource\_id) | The ARM resource ID of the source resource. DEPENDENCY: The source resource (e.g., storage account, resource group, event hub namespace) must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the Event Grid System Topic. | `map(string)` | `{}` | no |
| <a name="input_topic_type"></a> [topic\_type](#input\_topic\_type) | The type of the source resource. Examples: 'Microsoft.Storage.StorageAccounts', 'Microsoft.Resources.ResourceGroups', 'Microsoft.EventHub.Namespaces', 'Microsoft.ServiceBus.Namespaces', 'Microsoft.ContainerRegistry.Registries'. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name to include in the generated name. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_event_subscription_ids"></a> [event\_subscription\_ids](#output\_event\_subscription\_ids) | A map of event subscription names to their IDs. |
| <a name="output_event_subscriptions"></a> [event\_subscriptions](#output\_event\_subscriptions) | A map of event subscription names to their full resource objects. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Event Grid System Topic. |
| <a name="output_metric_arm_resource_id"></a> [metric\_arm\_resource\_id](#output\_metric\_arm\_resource\_id) | The Metric ARM Resource ID of the Event Grid System Topic. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Event Grid System Topic. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Managed Identity. Returns null if identity is not configured or if using UserAssigned identity only. |
| <a name="output_resource"></a> [resource](#output\_resource) | The full Event Grid System Topic resource object. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The Tenant ID of the System Assigned Managed Identity. Returns null if identity is not configured or if using UserAssigned identity only. |
<!-- END_TF_DOCS -->