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
| [azurerm_iothub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cloud_to_device"></a> [cloud\_to\_device](#input\_cloud\_to\_device) | Cloud to device messaging configuration. | <pre>object({<br/>    max_delivery_count = optional(number, 10)<br/>    default_ttl        = optional(string, "PT1H")<br/>    feedback = optional(object({<br/>      time_to_live       = optional(string, "PT1H")<br/>      max_delivery_count = optional(number, 10)<br/>      lock_duration      = optional(string, "PT60S")<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the IoT Hub resource. | `bool` | `true` | no |
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | Custom endpoints configuration. | <pre>list(object({<br/>    type                       = string<br/>    name                       = string<br/>    authentication_type        = optional(string)<br/>    identity_id                = optional(string)<br/>    endpoint_uri               = optional(string)<br/>    entity_path                = optional(string)<br/>    connection_string          = optional(string)<br/>    batch_frequency_in_seconds = optional(number)<br/>    max_chunk_size_in_bytes    = optional(number)<br/>    container_name             = optional(string)<br/>    encoding                   = optional(string)<br/>    file_name_format           = optional(string)<br/>    resource_group_name        = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_enrichments"></a> [enrichments](#input\_enrichments) | Message enrichments configuration. | <pre>list(object({<br/>    key            = string<br/>    value          = string<br/>    endpoint_names = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_event_hub_partition_count"></a> [event\_hub\_partition\_count](#input\_event\_hub\_partition\_count) | The number of partitions for the Event Hub-compatible endpoint. | `number` | `4` | no |
| <a name="input_event_hub_retention_in_days"></a> [event\_hub\_retention\_in\_days](#input\_event\_hub\_retention\_in\_days) | The retention time for device-to-cloud messages in days. | `number` | `1` | no |
| <a name="input_fallback_route"></a> [fallback\_route](#input\_fallback\_route) | Fallback route configuration. | <pre>object({<br/>    source         = optional(string, "DeviceMessages")<br/>    condition      = optional(string, "true")<br/>    endpoint_names = optional(list(string), ["events"])<br/>    enabled        = optional(bool, true)<br/>  })</pre> | `null` | no |
| <a name="input_file_upload"></a> [file\_upload](#input\_file\_upload) | File upload configuration. | <pre>object({<br/>    connection_string   = string<br/>    container_name      = string<br/>    sas_ttl             = optional(string, "PT1H")<br/>    notifications       = optional(bool, false)<br/>    lock_duration       = optional(string, "PT1M")<br/>    default_ttl         = optional(string, "PT1H")<br/>    max_delivery_count  = optional(number, 10)<br/>    authentication_type = optional(string)<br/>    identity_id         = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | A list of user-assigned managed identity IDs. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. Possible values are SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned. | `string` | `null` | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | Whether local authentication methods are enabled. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the IoT Hub should be created. | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum TLS version to support. Possible values are 1.0, 1.1, and 1.2. | `string` | `"1.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the IoT Hub. | `string` | n/a | yes |
| <a name="input_network_rule_sets"></a> [network\_rule\_sets](#input\_network\_rule\_sets) | Network rule sets configuration. | <pre>list(object({<br/>    default_action                     = optional(string, "Deny")<br/>    apply_to_builtin_eventhub_endpoint = optional(bool, false)<br/>    ip_rules = optional(list(object({<br/>      name    = string<br/>      ip_mask = string<br/>      action  = optional(string, "Allow")<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled for the IoT Hub. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the IoT Hub. | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | Message routing configuration. | <pre>list(object({<br/>    name           = string<br/>    source         = string<br/>    condition      = optional(string)<br/>    endpoint_names = list(string)<br/>    enabled        = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_sku_capacity"></a> [sku\_capacity](#input\_sku\_capacity) | The number of provisioned IoT Hub units. | `number` | `1` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The name of the SKU. Possible values are B1, B2, B3, F1, S1, S2, and S3. | `string` | `"S1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the IoT Hub. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_event_hub_events_endpoint"></a> [event\_hub\_events\_endpoint](#output\_event\_hub\_events\_endpoint) | The Event Hub-compatible endpoint. |
| <a name="output_event_hub_events_namespace"></a> [event\_hub\_events\_namespace](#output\_event\_hub\_events\_namespace) | The Event Hub-compatible namespace. |
| <a name="output_event_hub_events_path"></a> [event\_hub\_events\_path](#output\_event\_hub\_events\_path) | The Event Hub-compatible path. |
| <a name="output_event_hub_operations_endpoint"></a> [event\_hub\_operations\_endpoint](#output\_event\_hub\_operations\_endpoint) | The Event Hub-compatible operations endpoint. |
| <a name="output_event_hub_operations_path"></a> [event\_hub\_operations\_path](#output\_event\_hub\_operations\_path) | The Event Hub-compatible operations path. |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The hostname of the IoT Hub. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IoT Hub. |
| <a name="output_name"></a> [name](#output\_name) | The name of the IoT Hub. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned managed identity. |
| <a name="output_shared_access_policy"></a> [shared\_access\_policy](#output\_shared\_access\_policy) | The shared access policies of the IoT Hub. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenant ID of the system-assigned managed identity. |
| <a name="output_type"></a> [type](#output\_type) | The type of the IoT Hub. |
<!-- END_TF_DOCS -->