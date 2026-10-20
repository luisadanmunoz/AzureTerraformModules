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
| [azurerm_kubernetes_cluster_trusted_access_role_binding.kubernetes_cluster_trusted_access_role_binding](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_trusted_access_role_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#input\_kubernetes\_cluster\_id) | value to set the kubernetes cluster id | `string` | n/a | yes |
| <a name="input_kubernetes_cluster_trusted_access_role_binding_name"></a> [kubernetes\_cluster\_trusted\_access\_role\_binding\_name](#input\_kubernetes\_cluster\_trusted\_access\_role\_binding\_name) | value to set the kubernetes cluster trusted access role binding name | `string` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | value to set the roles | `list(string)` | n/a | yes |
| <a name="input_source_resource_id"></a> [source\_resource\_id](#input\_source\_resource\_id) | value to set the source resource id | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT KUBERNETES CLUSTER TRUSTED ACCESS ROLE BINDING ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->