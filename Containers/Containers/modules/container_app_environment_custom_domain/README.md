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
| [azurerm_container_app_environment_custom_domain.container_app_environment_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_custom_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_certificate_blob_base64"></a> [certificate\_blob\_base64](#input\_certificate\_blob\_base64) | value to set the certificate blob base64 | `string` | n/a | yes |
| <a name="input_certificate_password"></a> [certificate\_password](#input\_certificate\_password) | value to set the certificate password | `string` | n/a | yes |
| <a name="input_container_app_environment_custom_domain_name"></a> [container\_app\_environment\_custom\_domain\_name](#input\_container\_app\_environment\_custom\_domain\_name) | value to set the container app environment custom domain name | `string` | n/a | yes |
| <a name="input_container_app_environment_id"></a> [container\_app\_environment\_id](#input\_container\_app\_environment\_id) | value to set the container app environment id | `string` | n/a | yes |
| <a name="input_dns_suffix"></a> [dns\_suffix](#input\_dns\_suffix) | value to set the dns suffix | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dns_suffix"></a> [dns\_suffix](#output\_dns\_suffix) | n/a |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT CONTAINER APP ENVIRONMENT CUSTOM DOMAIN ############################################################################ |
<!-- END_TF_DOCS -->