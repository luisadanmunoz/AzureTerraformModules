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
| [azurerm_cognitive_account_rai_policy.cognitive_account_rai_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account_rai_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_base_policy_name"></a> [base\_policy\_name](#input\_base\_policy\_name) | value to set the base policy name | `string` | n/a | yes |
| <a name="input_cognitive_account_id"></a> [cognitive\_account\_id](#input\_cognitive\_account\_id) | value to set the cognitive account id | `string` | n/a | yes |
| <a name="input_cognitive_account_rai_policy_name"></a> [cognitive\_account\_rai\_policy\_name](#input\_cognitive\_account\_rai\_policy\_name) | value to set the cognitive account rai policy name | `string` | n/a | yes |
| <a name="input_content_filter"></a> [content\_filter](#input\_content\_filter) | value to set the content filter | <pre>list(object({<br/>    name               = string<br/>    filter_enabled     = bool<br/>    block_enabled      = bool<br/>    severity_threshold = string<br/>    source             = string<br/>  }))</pre> | n/a | yes |
| <a name="input_mode"></a> [mode](#input\_mode) | value to set the mode | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT COGNITIVE ACCOUNT RAI POLICY ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->