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
| [azurerm_machine_learning_compute_cluster.machine_learning_compute_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | value to set the local auth enabled flag | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_machine_learning_compute_cluster_name"></a> [machine\_learning\_compute\_cluster\_name](#input\_machine\_learning\_compute\_cluster\_name) | value to set the machine learning compute cluster name | `string` | n/a | yes |
| <a name="input_machine_learning_workspace_id"></a> [machine\_learning\_workspace\_id](#input\_machine\_learning\_workspace\_id) | value to set the machine learning workspace id | `string` | n/a | yes |
| <a name="input_node_public_ip_enabled"></a> [node\_public\_ip\_enabled](#input\_node\_public\_ip\_enabled) | value to set the node public ip enabled flag | `bool` | `null` | no |
| <a name="input_scale_settings"></a> [scale\_settings](#input\_scale\_settings) | value to set the scale settings | <pre>object({<br/>    max_node_count                       = number<br/>    min_node_count                       = number<br/>    scale_down_nodes_after_idle_duration = string<br/>  })</pre> | n/a | yes |
| <a name="input_ssh"></a> [ssh](#input\_ssh) | value to set the ssh | <pre>object({<br/>    admin_username = string<br/>    admin_password = optional(string)<br/>    key_value      = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_ssh_public_access_enabled"></a> [ssh\_public\_access\_enabled](#input\_ssh\_public\_access\_enabled) | value to set the ssh public access enabled flag | `bool` | `null` | no |
| <a name="input_subnet_resource_id"></a> [subnet\_resource\_id](#input\_subnet\_resource\_id) | value to set the subnet resource id | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_vm_priority"></a> [vm\_priority](#input\_vm\_priority) | value to set the vm priority | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | value to set the vm size | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MACHINE LEARNING COMPUTE CLUSTER ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->