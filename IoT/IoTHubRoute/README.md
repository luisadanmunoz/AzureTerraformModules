# Azure IoT Hub Route

Terraform module for creating and managing Azure IoT Hub message routes.

## Features

- Route messages from various sources to custom endpoints
- Support for routing conditions using IoT Hub query language
- Enable/disable routes without deletion
- Route from multiple message sources (device messages, lifecycle events, etc.)

## Usage

```hcl
module "iot_hub_route" {
  source = "path/to/IoT/IoTHubRoute"

  name                = "telemetry-route"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name
  source_type         = "DeviceMessages"
  endpoint_names      = ["storage-endpoint"]
  condition           = "true"
  enabled             = true
}
```

### Route with Condition

```hcl
module "iot_hub_route_critical" {
  source = "path/to/IoT/IoTHubRoute"

  name                = "critical-alerts-route"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name
  source_type         = "DeviceMessages"
  endpoint_names      = ["eventhub-endpoint"]
  condition           = "$body.temperature > 100"
  enabled             = true
}
```

### Route Lifecycle Events

```hcl
module "iot_hub_route_lifecycle" {
  source = "path/to/IoT/IoTHubRoute"

  name                = "device-lifecycle-route"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name
  source_type         = "DeviceLifecycleEvents"
  endpoint_names      = ["servicebus-queue-endpoint"]
  condition           = "true"
  enabled             = true
}
```

### Route Twin Change Events

```hcl
module "iot_hub_route_twin" {
  source = "path/to/IoT/IoTHubRoute"

  name                = "twin-changes-route"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name
  source_type         = "TwinChangeEvents"
  endpoint_names      = ["cosmosdb-endpoint"]
  condition           = "true"
  enabled             = true
}
```

## Message Sources

| Source | Description |
|--------|-------------|
| DeviceMessages | Telemetry messages from devices |
| DeviceLifecycleEvents | Device created/deleted events |
| DeviceConnectionStateEvents | Device connected/disconnected events |
| DeviceJobLifecycleEvents | Job lifecycle events |
| TwinChangeEvents | Device twin change events |
| DigitalTwinChangeEvents | Digital twin change events |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the route | `string` | n/a | yes |
| iothub_name | The name of the IoT Hub | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| source_type | The source for the route | `string` | n/a | yes |
| endpoint_names | The list of endpoint names | `list(string)` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| condition | The routing condition | `string` | `"true"` | no |
| enabled | Whether the route is enabled | `bool` | `true` | no |
| tags | Resource tags (not applied) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Route |
| name | The name of the Route |
| source | The source of the Route |
| condition | The condition of the Route |
| endpoint_names | The endpoint names of the Route |
| enabled | Whether the Route is enabled |

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
| [azurerm_iothub_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_condition"></a> [condition](#input\_condition) | The condition evaluated to apply the route. Defaults to true. | `string` | `"true"` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the route resource. | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the route is enabled. | `bool` | `true` | no |
| <a name="input_endpoint_names"></a> [endpoint\_names](#input\_endpoint\_names) | The list of endpoint names for the route. | `list(string)` | n/a | yes |
| <a name="input_iothub_name"></a> [iothub\_name](#input\_iothub\_name) | The name of the IoT Hub. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the route. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_source_type"></a> [source\_type](#input\_source\_type) | The source for the route. Possible values are DeviceConnectionStateEvents, DeviceJobLifecycleEvents, DeviceLifecycleEvents, DeviceMessages, DigitalTwinChangeEvents, Invalid, TwinChangeEvents. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (not applied to resource, kept for consistency). | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_condition"></a> [condition](#output\_condition) | The condition of the IoT Hub Route. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether the IoT Hub Route is enabled. |
| <a name="output_endpoint_names"></a> [endpoint\_names](#output\_endpoint\_names) | The endpoint names of the IoT Hub Route. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IoT Hub Route. |
| <a name="output_name"></a> [name](#output\_name) | The name of the IoT Hub Route. |
| <a name="output_source"></a> [source](#output\_source) | The source of the IoT Hub Route. |
<!-- END_TF_DOCS -->