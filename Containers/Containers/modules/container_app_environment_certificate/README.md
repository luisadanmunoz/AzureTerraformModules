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
| [azurerm_container_app_environment_certificate.container_app_environment_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_certificate_blob_base64"></a> [certificate\_blob\_base64](#input\_certificate\_blob\_base64) | value to set the certificate blob base64 | `string` | `null` | no |
| <a name="input_certificate_key_vault"></a> [certificate\_key\_vault](#input\_certificate\_key\_vault) | value to set the certificate key vault configuration | <pre>object({<br/>    identity            = optional(string)<br/>    key_vault_secret_id = string<br/>  })</pre> | `null` | no |
| <a name="input_certificate_password"></a> [certificate\_password](#input\_certificate\_password) | value to set the certificate password | `string` | `null` | no |
| <a name="input_container_app_environment_certificate_name"></a> [container\_app\_environment\_certificate\_name](#input\_container\_app\_environment\_certificate\_name) | value to set the container app environment certificate name | `string` | n/a | yes |
| <a name="input_container_app_environment_id"></a> [container\_app\_environment\_id](#input\_container\_app\_environment\_id) | value to set the container app environment id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT CONTAINER APP ENVIRONMENT CERTIFICATE ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_subject_name"></a> [subject\_name](#output\_subject\_name) | n/a |
| <a name="output_thumbprint"></a> [thumbprint](#output\_thumbprint) | n/a |
<!-- END_TF_DOCS -->