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
| [azurerm_cognitive_deployment.cognitive_deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cognitive_account_id"></a> [cognitive\_account\_id](#input\_cognitive\_account\_id) | value to set the cognitive account id | `string` | n/a | yes |
| <a name="input_cognitive_deployment_name"></a> [cognitive\_deployment\_name](#input\_cognitive\_deployment\_name) | value to set the cognitive deployment name | `string` | n/a | yes |
| <a name="input_dynamic_throttling_enabled"></a> [dynamic\_throttling\_enabled](#input\_dynamic\_throttling\_enabled) | value to set the dynamic throttling enabled flag | `bool` | `null` | no |
| <a name="input_model"></a> [model](#input\_model) | value to set the model | <pre>object({<br/>    format  = string<br/>    name    = string<br/>    version = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_rai_policy_name"></a> [rai\_policy\_name](#input\_rai\_policy\_name) | value to set the rai policy name | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | value to set the sku | <pre>object({<br/>    name     = string<br/>    capacity = optional(number)<br/>    family   = optional(string)<br/>    size     = optional(string)<br/>    tier     = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_version_upgrade_option"></a> [version\_upgrade\_option](#input\_version\_upgrade\_option) | value to set the version upgrade option | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT COGNITIVE DEPLOYMENT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->