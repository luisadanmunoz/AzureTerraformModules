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
| [azurerm_virtual_desktop_scaling_plan_host_pool_association.virtual_desktop_scaling_plan_host_pool_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_scaling_plan_host_pool_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | value to set the enabled flag | `bool` | n/a | yes |
| <a name="input_host_pool_id"></a> [host\_pool\_id](#input\_host\_pool\_id) | value to set the host pool id | `string` | n/a | yes |
| <a name="input_scaling_plan_id"></a> [scaling\_plan\_id](#input\_scaling\_plan\_id) | value to set the scaling plan id | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT VIRTUAL DESKTOP SCALING PLAN HOST POOL ASSOCIATION ############################################################################ |
<!-- END_TF_DOCS -->