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
| [azurerm_iothub_certificate.iothub_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_certificate_content"></a> [certificate\_content](#input\_certificate\_content) | value to set the certificate content | `string` | n/a | yes |
| <a name="input_iothub_certificate_name"></a> [iothub\_certificate\_name](#input\_iothub\_certificate\_name) | value to set the iot hub certificate name | `string` | n/a | yes |
| <a name="input_iothub_name"></a> [iothub\_name](#input\_iothub\_name) | value to set the iot hub name | `string` | n/a | yes |
| <a name="input_is_verified"></a> [is\_verified](#input\_is\_verified) | value to set the verified flag | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub certificate id |
| <a name="output_name"></a> [name](#output\_name) | value of the iot hub certificate name |
<!-- END_TF_DOCS -->