# Azure IoT Hub Endpoint

Terraform module for creating and managing Azure IoT Hub custom endpoints.

## Features

- Storage Container endpoint for archiving telemetry
- Event Hub endpoint for streaming data
- Service Bus Queue endpoint for reliable messaging
- Service Bus Topic endpoint for pub/sub scenarios
- Cosmos DB endpoint for direct database writes
- Support for both connection string and managed identity authentication

## Usage

### Storage Container Endpoint

```hcl
module "iot_hub_endpoint" {
  source = "path/to/IoT/IoTHubEndpoint"

  iothub_id           = module.iot_hub.id
  resource_group_name = azurerm_resource_group.main.name

  storage_container_endpoint = {
    name                       = "storage-endpoint"
    container_name             = "iot-data"
    connection_string          = azurerm_storage_account.main.primary_blob_connection_string
    batch_frequency_in_seconds = 60
    max_chunk_size_in_bytes    = 10485760
    encoding                   = "JSON"
    file_name_format           = "{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}"
  }
}
```

### Event Hub Endpoint

```hcl
module "iot_hub_endpoint" {
  source = "path/to/IoT/IoTHubEndpoint"

  iothub_id           = module.iot_hub.id
  resource_group_name = azurerm_resource_group.main.name

  eventhub_endpoint = {
    name              = "eventhub-endpoint"
    connection_string = azurerm_eventhub_authorization_rule.main.primary_connection_string
  }
}
```

### Service Bus Queue Endpoint

```hcl
module "iot_hub_endpoint" {
  source = "path/to/IoT/IoTHubEndpoint"

  iothub_id           = module.iot_hub.id
  resource_group_name = azurerm_resource_group.main.name

  servicebus_queue_endpoint = {
    name              = "servicebus-queue-endpoint"
    connection_string = azurerm_servicebus_queue_authorization_rule.main.primary_connection_string
  }
}
```

### Service Bus Topic Endpoint

```hcl
module "iot_hub_endpoint" {
  source = "path/to/IoT/IoTHubEndpoint"

  iothub_id           = module.iot_hub.id
  resource_group_name = azurerm_resource_group.main.name

  servicebus_topic_endpoint = {
    name              = "servicebus-topic-endpoint"
    connection_string = azurerm_servicebus_topic_authorization_rule.main.primary_connection_string
  }
}
```

### Cosmos DB Endpoint

```hcl
module "iot_hub_endpoint" {
  source = "path/to/IoT/IoTHubEndpoint"

  iothub_id           = module.iot_hub.id
  resource_group_name = azurerm_resource_group.main.name

  cosmosdb_endpoint = {
    name               = "cosmosdb-endpoint"
    container_name     = "iot-container"
    database_name      = "iot-database"
    endpoint_uri       = azurerm_cosmosdb_account.main.endpoint
    primary_key        = azurerm_cosmosdb_account.main.primary_key
    partition_key_name = "deviceId"
  }
}
```

### With Managed Identity

```hcl
module "iot_hub_endpoint" {
  source = "path/to/IoT/IoTHubEndpoint"

  iothub_id           = module.iot_hub.id
  resource_group_name = azurerm_resource_group.main.name

  storage_container_endpoint = {
    name                = "storage-endpoint-mi"
    container_name      = "iot-data"
    authentication_type = "identityBased"
    endpoint_uri        = azurerm_storage_account.main.primary_blob_endpoint
    identity_id         = azurerm_user_assigned_identity.main.id
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| iothub_id | The ID of the IoT Hub | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| create | Whether to create the resources | `bool` | `true` | no |
| storage_container_endpoint | Storage container endpoint config | `object` | `null` | no |
| eventhub_endpoint | Event Hub endpoint config | `object` | `null` | no |
| servicebus_queue_endpoint | Service Bus Queue endpoint config | `object` | `null` | no |
| servicebus_topic_endpoint | Service Bus Topic endpoint config | `object` | `null` | no |
| cosmosdb_endpoint | Cosmos DB endpoint config | `object` | `null` | no |
| tags | Resource tags (not applied) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| storage_container_endpoint_id | The ID of the Storage Container endpoint |
| storage_container_endpoint_name | The name of the Storage Container endpoint |
| eventhub_endpoint_id | The ID of the Event Hub endpoint |
| eventhub_endpoint_name | The name of the Event Hub endpoint |
| servicebus_queue_endpoint_id | The ID of the Service Bus Queue endpoint |
| servicebus_queue_endpoint_name | The name of the Service Bus Queue endpoint |
| servicebus_topic_endpoint_id | The ID of the Service Bus Topic endpoint |
| servicebus_topic_endpoint_name | The name of the Service Bus Topic endpoint |
| cosmosdb_endpoint_id | The ID of the Cosmos DB endpoint |
| cosmosdb_endpoint_name | The name of the Cosmos DB endpoint |

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
| [azurerm_iothub_endpoint_cosmosdb_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_endpoint_cosmosdb_account) | resource |
| [azurerm_iothub_endpoint_eventhub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_endpoint_eventhub) | resource |
| [azurerm_iothub_endpoint_servicebus_queue.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_endpoint_servicebus_queue) | resource |
| [azurerm_iothub_endpoint_servicebus_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_endpoint_servicebus_topic) | resource |
| [azurerm_iothub_endpoint_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_endpoint_storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cosmosdb_endpoint"></a> [cosmosdb\_endpoint](#input\_cosmosdb\_endpoint) | Cosmos DB endpoint configuration. | <pre>object({<br/>    name                       = string<br/>    container_name             = string<br/>    database_name              = string<br/>    authentication_type        = optional(string, "keyBased")<br/>    primary_key                = optional(string)<br/>    secondary_key              = optional(string)<br/>    identity_id                = optional(string)<br/>    endpoint_uri               = optional(string)<br/>    partition_key_name         = optional(string)<br/>    partition_key_template     = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the endpoint resources. | `bool` | `true` | no |
| <a name="input_eventhub_endpoint"></a> [eventhub\_endpoint](#input\_eventhub\_endpoint) | Event Hub endpoint configuration. | <pre>object({<br/>    name                = string<br/>    authentication_type = optional(string, "keyBased")<br/>    connection_string   = optional(string)<br/>    identity_id         = optional(string)<br/>    endpoint_uri        = optional(string)<br/>    entity_path         = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_iothub_id"></a> [iothub\_id](#input\_iothub\_id) | The ID of the IoT Hub. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_servicebus_queue_endpoint"></a> [servicebus\_queue\_endpoint](#input\_servicebus\_queue\_endpoint) | Service Bus Queue endpoint configuration. | <pre>object({<br/>    name                = string<br/>    authentication_type = optional(string, "keyBased")<br/>    connection_string   = optional(string)<br/>    identity_id         = optional(string)<br/>    endpoint_uri        = optional(string)<br/>    entity_path         = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_servicebus_topic_endpoint"></a> [servicebus\_topic\_endpoint](#input\_servicebus\_topic\_endpoint) | Service Bus Topic endpoint configuration. | <pre>object({<br/>    name                = string<br/>    authentication_type = optional(string, "keyBased")<br/>    connection_string   = optional(string)<br/>    identity_id         = optional(string)<br/>    endpoint_uri        = optional(string)<br/>    entity_path         = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_storage_container_endpoint"></a> [storage\_container\_endpoint](#input\_storage\_container\_endpoint) | Storage container endpoint configuration. | <pre>object({<br/>    name                       = string<br/>    container_name             = string<br/>    authentication_type        = optional(string, "keyBased")<br/>    connection_string          = optional(string)<br/>    identity_id                = optional(string)<br/>    endpoint_uri               = optional(string)<br/>    batch_frequency_in_seconds = optional(number, 300)<br/>    max_chunk_size_in_bytes    = optional(number, 314572800)<br/>    encoding                   = optional(string, "Avro")<br/>    file_name_format           = optional(string, "{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}")<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (not applied to resources, kept for consistency). | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cosmosdb_endpoint_id"></a> [cosmosdb\_endpoint\_id](#output\_cosmosdb\_endpoint\_id) | The ID of the Cosmos DB endpoint. |
| <a name="output_cosmosdb_endpoint_name"></a> [cosmosdb\_endpoint\_name](#output\_cosmosdb\_endpoint\_name) | The name of the Cosmos DB endpoint. |
| <a name="output_eventhub_endpoint_id"></a> [eventhub\_endpoint\_id](#output\_eventhub\_endpoint\_id) | The ID of the Event Hub endpoint. |
| <a name="output_eventhub_endpoint_name"></a> [eventhub\_endpoint\_name](#output\_eventhub\_endpoint\_name) | The name of the Event Hub endpoint. |
| <a name="output_servicebus_queue_endpoint_id"></a> [servicebus\_queue\_endpoint\_id](#output\_servicebus\_queue\_endpoint\_id) | The ID of the Service Bus Queue endpoint. |
| <a name="output_servicebus_queue_endpoint_name"></a> [servicebus\_queue\_endpoint\_name](#output\_servicebus\_queue\_endpoint\_name) | The name of the Service Bus Queue endpoint. |
| <a name="output_servicebus_topic_endpoint_id"></a> [servicebus\_topic\_endpoint\_id](#output\_servicebus\_topic\_endpoint\_id) | The ID of the Service Bus Topic endpoint. |
| <a name="output_servicebus_topic_endpoint_name"></a> [servicebus\_topic\_endpoint\_name](#output\_servicebus\_topic\_endpoint\_name) | The name of the Service Bus Topic endpoint. |
| <a name="output_storage_container_endpoint_id"></a> [storage\_container\_endpoint\_id](#output\_storage\_container\_endpoint\_id) | The ID of the Storage Container endpoint. |
| <a name="output_storage_container_endpoint_name"></a> [storage\_container\_endpoint\_name](#output\_storage\_container\_endpoint\_name) | The name of the Storage Container endpoint. |
<!-- END_TF_DOCS -->