<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_iothub_shared_access_policy.iothub_shared_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_shared_access_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_device_connect"></a> [device\_connect](#input\_device\_connect) | value to set the device connect permission | `bool` | `null` | no |
| <a name="input_iothub_name"></a> [iothub\_name](#input\_iothub\_name) | value to set the iot hub name | `string` | n/a | yes |
| <a name="input_iothub_shared_access_policy_name"></a> [iothub\_shared\_access\_policy\_name](#input\_iothub\_shared\_access\_policy\_name) | value to set the iot hub shared access policy name | `string` | n/a | yes |
| <a name="input_registry_read"></a> [registry\_read](#input\_registry\_read) | value to set the registry read permission | `bool` | `null` | no |
| <a name="input_registry_write"></a> [registry\_write](#input\_registry\_write) | value to set the registry write permission | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_service_connect"></a> [service\_connect](#input\_service\_connect) | value to set the service connect permission | `bool` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub shared access policy id |
| <a name="output_name"></a> [name](#output\_name) | value of the iot hub shared access policy name |
<!-- END_TF_DOCS -->