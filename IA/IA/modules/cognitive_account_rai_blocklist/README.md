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
| [azurerm_cognitive_account_rai_blocklist.cognitive_account_rai_blocklist](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account_rai_blocklist) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cognitive_account_id"></a> [cognitive\_account\_id](#input\_cognitive\_account\_id) | value to set the cognitive account id | `string` | n/a | yes |
| <a name="input_cognitive_account_rai_blocklist_name"></a> [cognitive\_account\_rai\_blocklist\_name](#input\_cognitive\_account\_rai\_blocklist\_name) | value to set the cognitive account rai blocklist name | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT COGNITIVE ACCOUNT RAI BLOCKLIST ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->