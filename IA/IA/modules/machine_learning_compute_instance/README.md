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
| [azurerm_machine_learning_compute_instance.machine_learning_compute_instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_assign_to_user"></a> [assign\_to\_user](#input\_assign\_to\_user) | value to set the assign to user | <pre>object({<br/>    object_id = optional(string)<br/>    tenant_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_authorization_type"></a> [authorization\_type](#input\_authorization\_type) | value to set the authorization type | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | value to set the local auth enabled flag | `bool` | `null` | no |
| <a name="input_machine_learning_compute_instance_name"></a> [machine\_learning\_compute\_instance\_name](#input\_machine\_learning\_compute\_instance\_name) | value to set the machine learning compute instance name | `string` | n/a | yes |
| <a name="input_machine_learning_workspace_id"></a> [machine\_learning\_workspace\_id](#input\_machine\_learning\_workspace\_id) | value to set the machine learning workspace id | `string` | n/a | yes |
| <a name="input_node_public_ip_enabled"></a> [node\_public\_ip\_enabled](#input\_node\_public\_ip\_enabled) | value to set the node public ip enabled flag | `bool` | `null` | no |
| <a name="input_ssh"></a> [ssh](#input\_ssh) | value to set the ssh | <pre>object({<br/>    public_key = string<br/>  })</pre> | `null` | no |
| <a name="input_subnet_resource_id"></a> [subnet\_resource\_id](#input\_subnet\_resource\_id) | value to set the subnet resource id | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | value to set the virtual machine size | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MACHINE LEARNING COMPUTE INSTANCE ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->