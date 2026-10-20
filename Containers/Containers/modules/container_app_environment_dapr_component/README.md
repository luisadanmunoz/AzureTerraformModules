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
| [azurerm_container_app_environment_dapr_component.container_app_environment_dapr_component](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_dapr_component) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_component_type"></a> [component\_type](#input\_component\_type) | value to set the component type | `string` | n/a | yes |
| <a name="input_component_version"></a> [component\_version](#input\_component\_version) | value to set the component version | `string` | n/a | yes |
| <a name="input_container_app_environment_dapr_component_name"></a> [container\_app\_environment\_dapr\_component\_name](#input\_container\_app\_environment\_dapr\_component\_name) | value to set the container app environment dapr component name | `string` | n/a | yes |
| <a name="input_container_app_environment_id"></a> [container\_app\_environment\_id](#input\_container\_app\_environment\_id) | value to set the container app environment id | `string` | n/a | yes |
| <a name="input_ignore_errors"></a> [ignore\_errors](#input\_ignore\_errors) | value to set the ignore errors flag | `bool` | `null` | no |
| <a name="input_init_timeout"></a> [init\_timeout](#input\_init\_timeout) | value to set the init timeout | `string` | `null` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | value to set the metadata | <pre>list(object({<br/>    name        = string<br/>    secret_name = optional(string)<br/>    value       = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | value to set the scopes | `list(string)` | `null` | no |
| <a name="input_secret"></a> [secret](#input\_secret) | value to set the secret | <pre>list(object({<br/>    name                = string<br/>    value               = optional(string)<br/>    identity            = optional(string)<br/>    key_vault_secret_id = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT CONTAINER APP ENVIRONMENT DAPR COMPONENT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->