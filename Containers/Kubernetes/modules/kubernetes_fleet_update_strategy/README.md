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
| [azurerm_kubernetes_fleet_update_strategy.kubernetes_fleet_update_strategy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_fleet_update_strategy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_kubernetes_fleet_manager_id"></a> [kubernetes\_fleet\_manager\_id](#input\_kubernetes\_fleet\_manager\_id) | value to set the kubernetes fleet manager id | `string` | n/a | yes |
| <a name="input_kubernetes_fleet_update_strategy_name"></a> [kubernetes\_fleet\_update\_strategy\_name](#input\_kubernetes\_fleet\_update\_strategy\_name) | value to set the kubernetes fleet update strategy name | `string` | n/a | yes |
| <a name="input_stages"></a> [stages](#input\_stages) | value to set the stages | <pre>list(object({<br/>    name                        = string<br/>    after_stage_wait_in_seconds = optional(number)<br/>    groups = list(object({<br/>      name = string<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT KUBERNETES FLEET UPDATE STRATEGY ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->