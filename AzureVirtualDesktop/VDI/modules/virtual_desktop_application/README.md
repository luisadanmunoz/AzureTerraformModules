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
| [azurerm_virtual_desktop_application.virtual_desktop_application](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_application_group_id"></a> [application\_group\_id](#input\_application\_group\_id) | value to set the application group id | `string` | n/a | yes |
| <a name="input_command_line_argument_policy"></a> [command\_line\_argument\_policy](#input\_command\_line\_argument\_policy) | value to set the command line argument policy | `string` | n/a | yes |
| <a name="input_command_line_arguments"></a> [command\_line\_arguments](#input\_command\_line\_arguments) | value to set the command line arguments | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | value to set the friendly name | `string` | `null` | no |
| <a name="input_icon_index"></a> [icon\_index](#input\_icon\_index) | value to set the icon index | `number` | `null` | no |
| <a name="input_icon_path"></a> [icon\_path](#input\_icon\_path) | value to set the icon path | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | value to set the path | `string` | n/a | yes |
| <a name="input_show_in_portal"></a> [show\_in\_portal](#input\_show\_in\_portal) | value to set the show in portal flag | `bool` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_virtual_desktop_application_name"></a> [virtual\_desktop\_application\_name](#input\_virtual\_desktop\_application\_name) | value to set the virtual desktop application name | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT VIRTUAL DESKTOP APPLICATION ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->