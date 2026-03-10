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
