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
