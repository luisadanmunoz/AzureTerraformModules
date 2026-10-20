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
| [azurerm_netapp_pool.netapp_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | value to set the account name | `string` | n/a | yes |
| <a name="input_cool_access_enabled"></a> [cool\_access\_enabled](#input\_cool\_access\_enabled) | value to set the cool access enabled | `bool` | `null` | no |
| <a name="input_custom_throughput_mibps"></a> [custom\_throughput\_mibps](#input\_custom\_throughput\_mibps) | value to set the custom throughput mibps | `number` | `null` | no |
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | value to set the encryption type | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_netapp_pool_name"></a> [netapp\_pool\_name](#input\_netapp\_pool\_name) | value to set the netapp pool name | `string` | n/a | yes |
| <a name="input_qos_type"></a> [qos\_type](#input\_qos\_type) | value to set the qos type | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_service_level"></a> [service\_level](#input\_service\_level) | value to set the service level | `string` | n/a | yes |
| <a name="input_size_in_tb"></a> [size\_in\_tb](#input\_size\_in\_tb) | value to set the size in tb | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT NETAPP POOL ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->