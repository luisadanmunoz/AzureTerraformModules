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
| [azurerm_kubernetes_cluster_extension.kubernetes_cluster_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | value to set the cluster id | `string` | n/a | yes |
| <a name="input_configuration_protected_settings"></a> [configuration\_protected\_settings](#input\_configuration\_protected\_settings) | value to set the configuration protected settings | `map(string)` | `null` | no |
| <a name="input_configuration_settings"></a> [configuration\_settings](#input\_configuration\_settings) | value to set the configuration settings | `map(string)` | `null` | no |
| <a name="input_extension_type"></a> [extension\_type](#input\_extension\_type) | value to set the extension type | `string` | n/a | yes |
| <a name="input_extension_version"></a> [extension\_version](#input\_extension\_version) | value to set the extension version | `string` | `null` | no |
| <a name="input_kubernetes_cluster_extension_name"></a> [kubernetes\_cluster\_extension\_name](#input\_kubernetes\_cluster\_extension\_name) | value to set the kubernetes cluster extension name | `string` | n/a | yes |
| <a name="input_plan"></a> [plan](#input\_plan) | value to set the plan | <pre>object({<br/>    name           = string<br/>    product        = string<br/>    publisher      = string<br/>    promotion_code = optional(string)<br/>    version        = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_release_namespace"></a> [release\_namespace](#input\_release\_namespace) | value to set the release namespace | `string` | `null` | no |
| <a name="input_release_train"></a> [release\_train](#input\_release\_train) | value to set the release train | `string` | `null` | no |
| <a name="input_target_namespace"></a> [target\_namespace](#input\_target\_namespace) | value to set the target namespace | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT KUBERNETES CLUSTER EXTENSION ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->