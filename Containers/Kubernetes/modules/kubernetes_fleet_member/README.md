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
| [azurerm_kubernetes_fleet_member.kubernetes_fleet_member](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_fleet_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_group"></a> [group](#input\_group) | value to set the group | `string` | `null` | no |
| <a name="input_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#input\_kubernetes\_cluster\_id) | value to set the kubernetes cluster id | `string` | n/a | yes |
| <a name="input_kubernetes_fleet_id"></a> [kubernetes\_fleet\_id](#input\_kubernetes\_fleet\_id) | value to set the kubernetes fleet id | `string` | n/a | yes |
| <a name="input_kubernetes_fleet_member_name"></a> [kubernetes\_fleet\_member\_name](#input\_kubernetes\_fleet\_member\_name) | value to set the kubernetes fleet member name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT KUBERNETES FLEET MEMBER ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->