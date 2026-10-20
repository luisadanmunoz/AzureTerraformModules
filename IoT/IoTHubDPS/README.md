# Azure IoT Hub Device Provisioning Service (DPS)

Terraform module for creating and managing Azure IoT Hub Device Provisioning Service resources.

## Features

- Automatic device provisioning for IoT Hub
- Multiple allocation policies (Hashed, GeoLatency, Static)
- Link multiple IoT Hubs for multi-hub scenarios
- IP filter rules for network security
- Data residency support
- Public network access control

## Usage

```hcl
module "iot_hub_dps" {
  source = "path/to/IoT/IoTHubDPS"

  name                = "my-iot-dps"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  allocation_policy = "Hashed"

  tags = {
    Environment = "Production"
  }
}
```

### With Linked IoT Hubs

```hcl
module "iot_hub_dps" {
  source = "path/to/IoT/IoTHubDPS"

  name                = "my-iot-dps"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  allocation_policy = "GeoLatency"

  linked_hubs = [
    {
      connection_string       = module.iot_hub_primary.shared_access_policy[0].primary_connection_string
      location                = "eastus"
      apply_allocation_policy = true
      allocation_weight       = 1
    },
    {
      connection_string       = module.iot_hub_secondary.shared_access_policy[0].primary_connection_string
      location                = "westus"
      apply_allocation_policy = true
      allocation_weight       = 1
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

### With IP Filter Rules

```hcl
module "iot_hub_dps" {
  source = "path/to/IoT/IoTHubDPS"

  name                = "my-iot-dps"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  public_network_access_enabled = true

  ip_filter_rules = [
    {
      name    = "allow-office"
      ip_mask = "10.0.0.0/24"
      action  = "Accept"
    },
    {
      name    = "deny-all"
      ip_mask = "0.0.0.0/0"
      action  = "Reject"
    }
  ]

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
| name | The name of the DPS | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| location | The Azure region | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| sku_name | The SKU name (S1) | `string` | `"S1"` | no |
| sku_capacity | The number of units | `number` | `1` | no |
| allocation_policy | Allocation policy (Hashed, GeoLatency, Static) | `string` | `"Hashed"` | no |
| data_residency_enabled | Enable data residency | `bool` | `false` | no |
| public_network_access_enabled | Enable public network access | `bool` | `true` | no |
| linked_hubs | List of linked IoT Hubs | `list(object)` | `[]` | no |
| ip_filter_rules | IP filter rules | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the DPS |
| name | The name of the DPS |
| service_operations_host_name | The service operations host name |
| device_provisioning_host_name | The device provisioning host name |
| id_scope | The unique identifier scope |
| allocation_policy | The allocation policy |

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
| [azurerm_iothub_dps.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allocation_policy"></a> [allocation\_policy](#input\_allocation\_policy) | The allocation policy for the DPS. Possible values are Hashed, GeoLatency, or Static. | `string` | `"Hashed"` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the DPS resource. | `bool` | `true` | no |
| <a name="input_data_residency_enabled"></a> [data\_residency\_enabled](#input\_data\_residency\_enabled) | Whether data residency is enabled. | `bool` | `false` | no |
| <a name="input_ip_filter_rules"></a> [ip\_filter\_rules](#input\_ip\_filter\_rules) | IP filter rules for the DPS. | <pre>list(object({<br/>    name    = string<br/>    ip_mask = string<br/>    action  = string<br/>    target  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_linked_hubs"></a> [linked\_hubs](#input\_linked\_hubs) | List of IoT Hubs to link to the DPS. | <pre>list(object({<br/>    connection_string       = string<br/>    location                = string<br/>    apply_allocation_policy = optional(bool, true)<br/>    allocation_weight       = optional(number, 1)<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the DPS should be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the IoT Hub Device Provisioning Service. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the DPS. | `string` | n/a | yes |
| <a name="input_sku_capacity"></a> [sku\_capacity](#input\_sku\_capacity) | The number of units to provision. | `number` | `1` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The name of the SKU. Currently only S1 is supported. | `string` | `"S1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the DPS. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_allocation_policy"></a> [allocation\_policy](#output\_allocation\_policy) | The allocation policy of the DPS. |
| <a name="output_device_provisioning_host_name"></a> [device\_provisioning\_host\_name](#output\_device\_provisioning\_host\_name) | The device provisioning host name of the DPS. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IoT Hub DPS. |
| <a name="output_id_scope"></a> [id\_scope](#output\_id\_scope) | The unique identifier scope for the DPS. |
| <a name="output_name"></a> [name](#output\_name) | The name of the IoT Hub DPS. |
| <a name="output_service_operations_host_name"></a> [service\_operations\_host\_name](#output\_service\_operations\_host\_name) | The service operations host name of the DPS. |
<!-- END_TF_DOCS -->