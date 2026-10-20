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
| [azurerm_virtual_desktop_host_pool.virtual_desktop_host_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_custom_rdp_properties"></a> [custom\_rdp\_properties](#input\_custom\_rdp\_properties) | value to set the custom rdp properties | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | value to set the friendly name | `string` | `null` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | value to set the load balancer type | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_maximum_sessions_allowed"></a> [maximum\_sessions\_allowed](#input\_maximum\_sessions\_allowed) | value to set the maximum sessions allowed | `number` | `null` | no |
| <a name="input_personal_desktop_assignment_type"></a> [personal\_desktop\_assignment\_type](#input\_personal\_desktop\_assignment\_type) | value to set the personal desktop assignment type | `string` | `null` | no |
| <a name="input_preferred_app_group_type"></a> [preferred\_app\_group\_type](#input\_preferred\_app\_group\_type) | value to set the preferred app group type | `string` | `null` | no |
| <a name="input_public_network_access"></a> [public\_network\_access](#input\_public\_network\_access) | value to set the public network access | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_scheduled_agent_updates"></a> [scheduled\_agent\_updates](#input\_scheduled\_agent\_updates) | value to set the scheduled agent updates | <pre>object({<br/>    enabled                   = optional(bool)<br/>    timezone                  = optional(string)<br/>    use_session_host_timezone = optional(bool)<br/>    schedule = optional(list(object({<br/>      day_of_week = string<br/>      hour_of_day = number<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_start_vm_on_connect"></a> [start\_vm\_on\_connect](#input\_start\_vm\_on\_connect) | value to set the start vm on connect flag | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | value to set the host pool type | `string` | n/a | yes |
| <a name="input_validate_environment"></a> [validate\_environment](#input\_validate\_environment) | value to set the validate environment flag | `bool` | `null` | no |
| <a name="input_virtual_desktop_host_pool_name"></a> [virtual\_desktop\_host\_pool\_name](#input\_virtual\_desktop\_host\_pool\_name) | value to set the virtual desktop host pool name | `string` | n/a | yes |
| <a name="input_vm_template"></a> [vm\_template](#input\_vm\_template) | value to set the vm template | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT VIRTUAL DESKTOP HOST POOL ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->