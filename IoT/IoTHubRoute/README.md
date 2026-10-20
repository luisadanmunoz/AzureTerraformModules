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
