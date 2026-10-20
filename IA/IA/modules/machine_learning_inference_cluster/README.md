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
| [azurerm_machine_learning_inference_cluster.machine_learning_inference_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cluster_purpose"></a> [cluster\_purpose](#input\_cluster\_purpose) | value to set the cluster purpose | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#input\_kubernetes\_cluster\_id) | value to set the kubernetes cluster id | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_machine_learning_inference_cluster_name"></a> [machine\_learning\_inference\_cluster\_name](#input\_machine\_learning\_inference\_cluster\_name) | value to set the machine learning inference cluster name | `string` | n/a | yes |
| <a name="input_machine_learning_workspace_id"></a> [machine\_learning\_workspace\_id](#input\_machine\_learning\_workspace\_id) | value to set the machine learning workspace id | `string` | n/a | yes |
| <a name="input_ssl"></a> [ssl](#input\_ssl) | value to set the ssl | <pre>object({<br/>    cert                      = optional(string)<br/>    cname                     = optional(string)<br/>    key                       = optional(string)<br/>    leaf_domain_label         = optional(string)<br/>    overwrite_existing_domain = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MACHINE LEARNING INFERENCE CLUSTER ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->