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
| [azurerm_security_center_contact.security_center_contact](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_alert_notifications"></a> [alert\_notifications](#input\_alert\_notifications) | value to set the alert notifications | `bool` | n/a | yes |
| <a name="input_alerts_to_admins"></a> [alerts\_to\_admins](#input\_alerts\_to\_admins) | value to set the alerts to admins | `bool` | n/a | yes |
| <a name="input_email"></a> [email](#input\_email) | value to set the email | `string` | n/a | yes |
| <a name="input_phone"></a> [phone](#input\_phone) | value to set the phone | `string` | `null` | no |
| <a name="input_security_center_contact_name"></a> [security\_center\_contact\_name](#input\_security\_center\_contact\_name) | value to set the security center contact name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT SECURITY CENTER CONTACT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->