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
| [azurerm_virtual_machine_extension.virtual_machine_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_auto_upgrade_minor_version"></a> [auto\_upgrade\_minor\_version](#input\_auto\_upgrade\_minor\_version) | value to set the auto upgrade minor version | `bool` | `null` | no |
| <a name="input_automatic_upgrade_enabled"></a> [automatic\_upgrade\_enabled](#input\_automatic\_upgrade\_enabled) | value to set the automatic upgrade enabled | `bool` | `null` | no |
| <a name="input_failure_suppression_enabled"></a> [failure\_suppression\_enabled](#input\_failure\_suppression\_enabled) | value to set the failure suppression enabled | `bool` | `null` | no |
| <a name="input_protected_settings"></a> [protected\_settings](#input\_protected\_settings) | value to set the protected settings | `any` | `null` | no |
| <a name="input_protected_settings_from_key_vault"></a> [protected\_settings\_from\_key\_vault](#input\_protected\_settings\_from\_key\_vault) | value to set the protected settings from key vault | <pre>object({<br/>    secret_url      = string<br/>    source_vault_id = string<br/>  })</pre> | `null` | no |
| <a name="input_provision_after_extensions"></a> [provision\_after\_extensions](#input\_provision\_after\_extensions) | value to set the provision after extensions | `list(string)` | `null` | no |
| <a name="input_publisher"></a> [publisher](#input\_publisher) | value to set the publisher | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | value to set the settings | `any` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | value to set the type | `string` | n/a | yes |
| <a name="input_type_handler_version"></a> [type\_handler\_version](#input\_type\_handler\_version) | value to set the type handler version | `string` | n/a | yes |
| <a name="input_virtual_machine_extension_name"></a> [virtual\_machine\_extension\_name](#input\_virtual\_machine\_extension\_name) | value to set the virtual machine extension name | `string` | n/a | yes |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | value to set the virtual machine id | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT VIRTUAL MACHINE EXTENSION ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->