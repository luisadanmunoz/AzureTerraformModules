# Azure IoT Hub

Terraform module for creating and managing Azure IoT Hub resources.

## Features

- Configurable SKU (Basic or Standard tiers)
- Cloud-to-device messaging configuration
- File upload support with Azure Storage integration
- Network rules and IP filtering
- Custom endpoints (Event Hub, Service Bus, Storage)
- Message routing and enrichments
- Managed identity support (System and User assigned)
- Fallback route configuration

## Usage

```hcl
module "iot_hub" {
  source = "path/to/IoT/IoTHub"

  name                = "my-iot-hub"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  tags = {
    Environment = "Production"
  }
}
```

### With Cloud-to-Device Configuration

```hcl
module "iot_hub" {
  source = "path/to/IoT/IoTHub"

  name                = "my-iot-hub"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name = "S1"

  cloud_to_device = {
    max_delivery_count = 10
    default_ttl        = "PT1H"
    feedback = {
      time_to_live       = "PT1H"
      max_delivery_count = 10
      lock_duration      = "PT60S"
    }
  }

  tags = {
    Environment = "Production"
  }
}
```

### With Message Routing

```hcl
module "iot_hub" {
  source = "path/to/IoT/IoTHub"

  name                = "my-iot-hub"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name = "S1"

  routes = [
    {
      name           = "telemetry-route"
      source         = "DeviceMessages"
      condition      = "true"
      endpoint_names = ["events"]
      enabled        = true
    }
  ]

  enrichments = [
    {
      key            = "tenant"
      value          = "$twin.tags.tenant"
      endpoint_names = ["events"]
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

### With Managed Identity

```hcl
module "iot_hub" {
  source = "path/to/IoT/IoTHub"

  name                = "my-iot-hub"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name = "S1"

  identity_type = "SystemAssigned"

  tags = {
    Environment = "Production"
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
| name | The name of the IoT Hub | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| location | The Azure region | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| sku_name | The SKU name (B1, B2, B3, F1, S1, S2, S3) | `string` | `"S1"` | no |
| sku_capacity | The number of IoT Hub units | `number` | `1` | no |
| event_hub_partition_count | Number of partitions for Event Hub endpoint | `number` | `4` | no |
| event_hub_retention_in_days | Retention time for messages in days | `number` | `1` | no |
| public_network_access_enabled | Enable public network access | `bool` | `true` | no |
| min_tls_version | Minimum TLS version | `string` | `"1.2"` | no |
| local_authentication_enabled | Enable local authentication | `bool` | `true` | no |
| cloud_to_device | Cloud-to-device configuration | `object` | `null` | no |
| file_upload | File upload configuration | `object` | `null` | no |
| network_rule_sets | Network rule sets | `list(object)` | `[]` | no |
| endpoints | Custom endpoints | `list(object)` | `[]` | no |
| routes | Message routes | `list(object)` | `[]` | no |
| fallback_route | Fallback route configuration | `object` | `null` | no |
| enrichments | Message enrichments | `list(object)` | `[]` | no |
| identity_type | Managed identity type | `string` | `null` | no |
| identity_ids | User-assigned identity IDs | `list(string)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the IoT Hub |
| name | The name of the IoT Hub |
| hostname | The hostname of the IoT Hub |
| type | The type of the IoT Hub |
| event_hub_events_endpoint | The Event Hub-compatible endpoint |
| event_hub_events_namespace | The Event Hub-compatible namespace |
| event_hub_events_path | The Event Hub-compatible path |
| event_hub_operations_endpoint | The operations endpoint |
| event_hub_operations_path | The operations path |
| principal_id | The principal ID of the managed identity |
| tenant_id | The tenant ID of the managed identity |
| shared_access_policy | The shared access policies (sensitive) |
