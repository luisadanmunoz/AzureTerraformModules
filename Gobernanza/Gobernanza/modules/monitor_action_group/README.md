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
| [azurerm_monitor_action_group.monitor_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_action_group_name"></a> [action\_group\_name](#input\_action\_group\_name) | value to set the action group name | `string` | n/a | yes |
| <a name="input_arm_role_receivers"></a> [arm\_role\_receivers](#input\_arm\_role\_receivers) | value to set the arm role receivers | <pre>list(object({<br/>    name                    = string<br/>    role_id                 = string<br/>    use_common_alert_schema = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_email_receivers"></a> [email\_receivers](#input\_email\_receivers) | value to set the email receivers | <pre>list(object({<br/>    name                    = string<br/>    email_address           = string<br/>    use_common_alert_schema = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | value to set the enabled flag | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_short_name"></a> [short\_name](#input\_short\_name) | value to set the short name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_webhook_receivers"></a> [webhook\_receivers](#input\_webhook\_receivers) | value to set the webhook receivers | <pre>list(object({<br/>    name                    = string<br/>    service_uri             = string<br/>    use_common_alert_schema = optional(bool)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MONITOR ACTION GROUP ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->