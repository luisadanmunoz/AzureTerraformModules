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
| [azurerm_container_app_custom_domain.container_app_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_custom_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_certificate_binding_type"></a> [certificate\_binding\_type](#input\_certificate\_binding\_type) | value to set the certificate binding type | `string` | `null` | no |
| <a name="input_container_app_custom_domain_name"></a> [container\_app\_custom\_domain\_name](#input\_container\_app\_custom\_domain\_name) | value to set the container app custom domain name | `string` | n/a | yes |
| <a name="input_container_app_environment_certificate_id"></a> [container\_app\_environment\_certificate\_id](#input\_container\_app\_environment\_certificate\_id) | value to set the container app environment certificate id | `string` | `null` | no |
| <a name="input_container_app_id"></a> [container\_app\_id](#input\_container\_app\_id) | value to set the container app id | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_container_app_environment_managed_certificate_id"></a> [container\_app\_environment\_managed\_certificate\_id](#output\_container\_app\_environment\_managed\_certificate\_id) | n/a |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT CONTAINER APP CUSTOM DOMAIN ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->