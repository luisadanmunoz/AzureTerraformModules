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
| [azurerm_key_vault_secret.key_vault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | value to set the content type | `string` | `null` | no |
| <a name="input_expiration_date"></a> [expiration\_date](#input\_expiration\_date) | value to set the expiration date | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | value to set the key vault id | `string` | n/a | yes |
| <a name="input_key_vault_secret_name"></a> [key\_vault\_secret\_name](#input\_key\_vault\_secret\_name) | value to set the key vault secret name | `string` | n/a | yes |
| <a name="input_not_before_date"></a> [not\_before\_date](#input\_not\_before\_date) | value to set the not before date | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_value"></a> [value](#input\_value) | value to set the secret value | `string` | `null` | no |
| <a name="input_value_wo"></a> [value\_wo](#input\_value\_wo) | value to set the write only secret value | `string` | `null` | no |
| <a name="input_value_wo_version"></a> [value\_wo\_version](#input\_value\_wo\_version) | value to set the write only value version | `number` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT KEY VAULT SECRET ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_resource_versionless_id"></a> [resource\_versionless\_id](#output\_resource\_versionless\_id) | n/a |
| <a name="output_versionless_id"></a> [versionless\_id](#output\_versionless\_id) | n/a |
<!-- END_TF_DOCS -->