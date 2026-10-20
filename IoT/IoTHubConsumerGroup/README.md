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
| [azurerm_iothub_consumer_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_consumer_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the consumer group resource. | `bool` | `true` | no |
| <a name="input_eventhub_endpoint_name"></a> [eventhub\_endpoint\_name](#input\_eventhub\_endpoint\_name) | The name of the Event Hub-compatible endpoint in the IoT Hub. | `string` | n/a | yes |
| <a name="input_iothub_name"></a> [iothub\_name](#input\_iothub\_name) | The name of the IoT Hub. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the consumer group. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (not applied to resource, kept for consistency). | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_eventhub_endpoint_name"></a> [eventhub\_endpoint\_name](#output\_eventhub\_endpoint\_name) | The name of the Event Hub-compatible endpoint. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IoT Hub Consumer Group. |
| <a name="output_iothub_name"></a> [iothub\_name](#output\_iothub\_name) | The name of the IoT Hub. |
| <a name="output_name"></a> [name](#output\_name) | The name of the IoT Hub Consumer Group. |
<!-- END_TF_DOCS -->