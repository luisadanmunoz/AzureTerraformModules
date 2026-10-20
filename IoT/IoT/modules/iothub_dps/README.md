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
| [azurerm_iothub_dps.iothub_dps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allocation_policy"></a> [allocation\_policy](#input\_allocation\_policy) | value to set the allocation policy | `string` | `null` | no |
| <a name="input_data_residency_enabled"></a> [data\_residency\_enabled](#input\_data\_residency\_enabled) | value to set the data residency enabled flag | `bool` | `null` | no |
| <a name="input_iothub_dps_name"></a> [iothub\_dps\_name](#input\_iothub\_dps\_name) | value to set the iot hub dps name | `string` | n/a | yes |
| <a name="input_ip_filter_rule"></a> [ip\_filter\_rule](#input\_ip\_filter\_rule) | value to set the ip filter rules | <pre>list(object({<br/>    name    = string<br/>    ip_mask = string<br/>    action  = string<br/>    target  = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_linked_hub"></a> [linked\_hub](#input\_linked\_hub) | value to set the linked hubs | <pre>list(object({<br/>    connection_string       = string<br/>    location                = string<br/>    allocation_weight       = optional(number)<br/>    apply_allocation_policy = optional(bool)<br/>  }))</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | value to set the public network access enabled flag | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | value to set the sku | <pre>object({<br/>    name     = string<br/>    capacity = number<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_device_provisioning_host_name"></a> [device\_provisioning\_host\_name](#output\_device\_provisioning\_host\_name) | value of the iot hub dps device provisioning host name |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub dps id |
| <a name="output_id_scope"></a> [id\_scope](#output\_id\_scope) | value of the iot hub dps id scope |
| <a name="output_name"></a> [name](#output\_name) | value of the iot hub dps name |
<!-- END_TF_DOCS -->