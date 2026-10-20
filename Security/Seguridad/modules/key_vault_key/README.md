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
| [azurerm_key_vault_key.key_vault_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_curve"></a> [curve](#input\_curve) | value to set the curve | `string` | `null` | no |
| <a name="input_expiration_date"></a> [expiration\_date](#input\_expiration\_date) | value to set the expiration date | `string` | `null` | no |
| <a name="input_key_opts"></a> [key\_opts](#input\_key\_opts) | value to set the key options | `list(string)` | n/a | yes |
| <a name="input_key_size"></a> [key\_size](#input\_key\_size) | value to set the key size | `number` | `null` | no |
| <a name="input_key_type"></a> [key\_type](#input\_key\_type) | value to set the key type | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | value to set the key vault id | `string` | n/a | yes |
| <a name="input_key_vault_key_name"></a> [key\_vault\_key\_name](#input\_key\_vault\_key\_name) | value to set the key vault key name | `string` | n/a | yes |
| <a name="input_not_before_date"></a> [not\_before\_date](#input\_not\_before\_date) | value to set the not before date | `string` | `null` | no |
| <a name="input_rotation_policy"></a> [rotation\_policy](#input\_rotation\_policy) | value to set the rotation policy | <pre>object({<br/>    expire_after         = optional(string)<br/>    notify_before_expiry = optional(string)<br/>    automatic = optional(object({<br/>      time_after_creation = optional(string)<br/>      time_before_expiry  = optional(string)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT KEY VAULT KEY ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_resource_versionless_id"></a> [resource\_versionless\_id](#output\_resource\_versionless\_id) | n/a |
| <a name="output_versionless_id"></a> [versionless\_id](#output\_versionless\_id) | n/a |
<!-- END_TF_DOCS -->