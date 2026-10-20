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
| [azurerm_iothub_enrichment.iothub_enrichment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_enrichment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_endpoint_names"></a> [endpoint\_names](#input\_endpoint\_names) | value to set the endpoint names | `list(string)` | n/a | yes |
| <a name="input_iothub_name"></a> [iothub\_name](#input\_iothub\_name) | value to set the iot hub name | `string` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | value to set the key | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_value"></a> [value](#input\_value) | value to set the value | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub enrichment id |
| <a name="output_key"></a> [key](#output\_key) | value of the iot hub enrichment key |
<!-- END_TF_DOCS -->