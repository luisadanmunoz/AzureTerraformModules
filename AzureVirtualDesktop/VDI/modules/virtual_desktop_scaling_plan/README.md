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
| [azurerm_virtual_desktop_scaling_plan.virtual_desktop_scaling_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_scaling_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_exclusion_tag"></a> [exclusion\_tag](#input\_exclusion\_tag) | value to set the exclusion tag | `string` | `null` | no |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | value to set the friendly name | `string` | `null` | no |
| <a name="input_host_pool"></a> [host\_pool](#input\_host\_pool) | value to set the host pool inline associations | <pre>list(object({<br/>    hostpool_id          = string<br/>    scaling_plan_enabled = bool<br/>  }))</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | value to set the schedules | <pre>list(object({<br/>    name                                 = string<br/>    days_of_week                         = list(string)<br/>    ramp_up_start_time                   = string<br/>    ramp_up_load_balancing_algorithm     = string<br/>    ramp_up_minimum_hosts_percent        = optional(number)<br/>    ramp_up_capacity_threshold_percent   = optional(number)<br/>    peak_start_time                      = string<br/>    peak_load_balancing_algorithm        = string<br/>    ramp_down_start_time                 = string<br/>    ramp_down_load_balancing_algorithm   = string<br/>    ramp_down_minimum_hosts_percent      = number<br/>    ramp_down_force_logoff_users         = bool<br/>    ramp_down_wait_time_minutes          = number<br/>    ramp_down_notification_message       = string<br/>    ramp_down_capacity_threshold_percent = number<br/>    ramp_down_stop_hosts_when            = string<br/>    off_peak_start_time                  = string<br/>    off_peak_load_balancing_algorithm    = string<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_time_zone"></a> [time\_zone](#input\_time\_zone) | value to set the time zone | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_virtual_desktop_scaling_plan_name"></a> [virtual\_desktop\_scaling\_plan\_name](#input\_virtual\_desktop\_scaling\_plan\_name) | value to set the virtual desktop scaling plan name | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT VIRTUAL DESKTOP SCALING PLAN ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->