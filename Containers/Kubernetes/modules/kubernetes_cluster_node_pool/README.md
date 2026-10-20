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
| [azurerm_kubernetes_cluster_node_pool.kubernetes_cluster_node_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_auto_scaling_enabled"></a> [auto\_scaling\_enabled](#input\_auto\_scaling\_enabled) | value to set the auto scaling enabled | `bool` | `null` | no |
| <a name="input_kubelet_config"></a> [kubelet\_config](#input\_kubelet\_config) | value to set the kubelet config | <pre>object({<br/>    allowed_unsafe_sysctls    = optional(list(string))<br/>    container_log_max_line    = optional(number)<br/>    container_log_max_size_mb = optional(number)<br/>    cpu_cfs_quota_enabled     = optional(bool)<br/>    cpu_cfs_quota_period      = optional(string)<br/>    cpu_manager_policy        = optional(string)<br/>    image_gc_high_threshold   = optional(number)<br/>    image_gc_low_threshold    = optional(number)<br/>    pod_max_pid               = optional(number)<br/>    topology_manager_policy   = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#input\_kubernetes\_cluster\_id) | value to set the kubernetes cluster id | `string` | n/a | yes |
| <a name="input_kubernetes_cluster_node_pool_name"></a> [kubernetes\_cluster\_node\_pool\_name](#input\_kubernetes\_cluster\_node\_pool\_name) | value to set the kubernetes cluster node pool name | `string` | n/a | yes |
| <a name="input_linux_os_config"></a> [linux\_os\_config](#input\_linux\_os\_config) | value to set the linux os config | <pre>object({<br/>    swap_file_size_mb            = optional(number)<br/>    transparent_huge_page        = optional(string)<br/>    transparent_huge_page_defrag = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | value to set the max count | `number` | `null` | no |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | value to set the max pods | `number` | `null` | no |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | value to set the min count | `number` | `null` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | value to set the mode | `string` | `null` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | value to set the node count | `number` | `null` | no |
| <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels) | value to set the node labels | `map(string)` | `null` | no |
| <a name="input_node_public_ip_enabled"></a> [node\_public\_ip\_enabled](#input\_node\_public\_ip\_enabled) | value to set the node public ip enabled | `bool` | `null` | no |
| <a name="input_node_public_ip_prefix_id"></a> [node\_public\_ip\_prefix\_id](#input\_node\_public\_ip\_prefix\_id) | value to set the node public ip prefix id | `string` | `null` | no |
| <a name="input_node_taints"></a> [node\_taints](#input\_node\_taints) | value to set the node taints | `list(string)` | `null` | no |
| <a name="input_orchestrator_version"></a> [orchestrator\_version](#input\_orchestrator\_version) | value to set the orchestrator version | `string` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | value to set the os disk size gb | `number` | `null` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | value to set the os disk type | `string` | `null` | no |
| <a name="input_os_sku"></a> [os\_sku](#input\_os\_sku) | value to set the os sku | `string` | `null` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | value to set the os type | `string` | `null` | no |
| <a name="input_pod_subnet_id"></a> [pod\_subnet\_id](#input\_pod\_subnet\_id) | value to set the pod subnet id | `string` | `null` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | value to set the priority | `string` | `null` | no |
| <a name="input_scale_down_mode"></a> [scale\_down\_mode](#input\_scale\_down\_mode) | value to set the scale down mode | `string` | `null` | no |
| <a name="input_spot_max_price"></a> [spot\_max\_price](#input\_spot\_max\_price) | value to set the spot max price | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_temporary_name_for_rotation"></a> [temporary\_name\_for\_rotation](#input\_temporary\_name\_for\_rotation) | value to set the temporary name for rotation | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_ultra_ssd_enabled"></a> [ultra\_ssd\_enabled](#input\_ultra\_ssd\_enabled) | value to set the ultra ssd enabled | `bool` | `null` | no |
| <a name="input_upgrade_settings"></a> [upgrade\_settings](#input\_upgrade\_settings) | value to set the upgrade settings | <pre>object({<br/>    max_surge                     = string<br/>    drain_timeout_in_minutes      = optional(number)<br/>    node_soak_duration_in_minutes = optional(number)<br/>    undrainable_node_behavior     = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | value to set the vm size | `string` | `null` | no |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | value to set the vnet subnet id | `string` | `null` | no |
| <a name="input_workload_runtime"></a> [workload\_runtime](#input\_workload\_runtime) | value to set the workload runtime | `string` | `null` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | value to set the zones | `list(string)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT KUBERNETES CLUSTER NODE POOL ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->