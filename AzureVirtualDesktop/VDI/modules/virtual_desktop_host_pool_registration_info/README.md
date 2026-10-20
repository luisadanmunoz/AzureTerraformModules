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
| [azurerm_virtual_desktop_host_pool_registration_info.virtual_desktop_host_pool_registration_info](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool_registration_info) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_expiration_date"></a> [expiration\_date](#input\_expiration\_date) | value to set the expiration date | `string` | n/a | yes |
| <a name="input_hostpool_id"></a> [hostpool\_id](#input\_hostpool\_id) | value to set the host pool id | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT VIRTUAL DESKTOP HOST POOL REGISTRATION INFO ############################################################################ |
| <a name="output_token"></a> [token](#output\_token) | n/a |
<!-- END_TF_DOCS -->