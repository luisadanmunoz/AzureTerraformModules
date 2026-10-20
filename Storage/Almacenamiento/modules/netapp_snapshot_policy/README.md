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
| [azurerm_netapp_snapshot_policy.netapp_snapshot_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_snapshot_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | value to set the account name | `string` | n/a | yes |
| <a name="input_daily_schedule"></a> [daily\_schedule](#input\_daily\_schedule) | value to set the daily schedule | <pre>object({<br/>    hour              = number<br/>    minute            = number<br/>    snapshots_to_keep = number<br/>  })</pre> | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | value to set the enabled | `bool` | n/a | yes |
| <a name="input_hourly_schedule"></a> [hourly\_schedule](#input\_hourly\_schedule) | value to set the hourly schedule | <pre>object({<br/>    minute            = number<br/>    snapshots_to_keep = number<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_monthly_schedule"></a> [monthly\_schedule](#input\_monthly\_schedule) | value to set the monthly schedule | <pre>object({<br/>    days_of_month     = list(number)<br/>    hour              = number<br/>    minute            = number<br/>    snapshots_to_keep = number<br/>  })</pre> | `null` | no |
| <a name="input_netapp_snapshot_policy_name"></a> [netapp\_snapshot\_policy\_name](#input\_netapp\_snapshot\_policy\_name) | value to set the netapp snapshot policy name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_weekly_schedule"></a> [weekly\_schedule](#input\_weekly\_schedule) | value to set the weekly schedule | <pre>object({<br/>    days_of_week      = list(string)<br/>    hour              = number<br/>    minute            = number<br/>    snapshots_to_keep = number<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT NETAPP SNAPSHOT POLICY ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->