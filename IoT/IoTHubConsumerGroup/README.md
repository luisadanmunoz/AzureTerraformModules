# Azure IoT Hub Consumer Group

Terraform module for creating and managing Azure IoT Hub Consumer Groups.

## Features

- Create consumer groups for Event Hub-compatible endpoints
- Support for both events and operations endpoints
- Conditional resource creation

## Usage

```hcl
module "iot_hub_consumer_group" {
  source = "path/to/IoT/IoTHubConsumerGroup"

  name                   = "my-consumer-group"
  iothub_name            = module.iot_hub.name
  resource_group_name    = azurerm_resource_group.main.name
  eventhub_endpoint_name = "events"
}
```

### Multiple Consumer Groups

```hcl
module "consumer_group_analytics" {
  source = "path/to/IoT/IoTHubConsumerGroup"

  name                   = "analytics-consumer"
  iothub_name            = module.iot_hub.name
  resource_group_name    = azurerm_resource_group.main.name
  eventhub_endpoint_name = "events"
}

module "consumer_group_processing" {
  source = "path/to/IoT/IoTHubConsumerGroup"

  name                   = "processing-consumer"
  iothub_name            = module.iot_hub.name
  resource_group_name    = azurerm_resource_group.main.name
  eventhub_endpoint_name = "events"
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
| name | The name of the consumer group | `string` | n/a | yes |
| iothub_name | The name of the IoT Hub | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| eventhub_endpoint_name | The Event Hub-compatible endpoint name | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| tags | Resource tags (not applied) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Consumer Group |
| name | The name of the Consumer Group |
| iothub_name | The name of the IoT Hub |
| eventhub_endpoint_name | The Event Hub-compatible endpoint name |
