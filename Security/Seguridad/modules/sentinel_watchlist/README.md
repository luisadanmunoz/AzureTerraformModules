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
| [azurerm_sentinel_watchlist.sentinel_watchlist](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_watchlist) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_default_duration"></a> [default\_duration](#input\_default\_duration) | value to set the default duration | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | value to set the display name | `string` | n/a | yes |
| <a name="input_item_search_key"></a> [item\_search\_key](#input\_item\_search\_key) | value to set the item search key | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | value to set the labels | `list(string)` | `null` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | value to set the log analytics workspace id | `string` | n/a | yes |
| <a name="input_sentinel_watchlist_name"></a> [sentinel\_watchlist\_name](#input\_sentinel\_watchlist\_name) | value to set the sentinel watchlist name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT SENTINEL WATCHLIST ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->