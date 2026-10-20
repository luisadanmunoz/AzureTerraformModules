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
| [azurerm_kubernetes_cluster.kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_api_server_access_profile"></a> [api\_server\_access\_profile](#input\_api\_server\_access\_profile) | value to set the api server access profile | <pre>object({<br/>    authorized_ip_ranges                = optional(list(string))<br/>    subnet_id                           = optional(string)<br/>    virtual_network_integration_enabled = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_automatic_upgrade_channel"></a> [automatic\_upgrade\_channel](#input\_automatic\_upgrade\_channel) | value to set the automatic upgrade channel | `string` | `null` | no |
| <a name="input_azure_active_directory_role_based_access_control"></a> [azure\_active\_directory\_role\_based\_access\_control](#input\_azure\_active\_directory\_role\_based\_access\_control) | value to set the azure active directory role based access control | <pre>object({<br/>    admin_group_object_ids = optional(list(string))<br/>    azure_rbac_enabled     = optional(bool)<br/>    tenant_id              = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | value to set the azure policy enabled | `bool` | `null` | no |
| <a name="input_cost_analysis_enabled"></a> [cost\_analysis\_enabled](#input\_cost\_analysis\_enabled) | value to set the cost analysis enabled | `bool` | `null` | no |
| <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool) | value to set the default node pool | <pre>object({<br/>    name                         = string<br/>    vm_size                      = optional(string)<br/>    node_count                   = optional(number)<br/>    auto_scaling_enabled         = optional(bool)<br/>    min_count                    = optional(number)<br/>    max_count                    = optional(number)<br/>    max_pods                     = optional(number)<br/>    node_labels                  = optional(map(string))<br/>    node_public_ip_enabled       = optional(bool)<br/>    only_critical_addons_enabled = optional(bool)<br/>    orchestrator_version         = optional(string)<br/>    os_disk_size_gb              = optional(number)<br/>    os_disk_type                 = optional(string)<br/>    os_sku                       = optional(string)<br/>    pod_subnet_id                = optional(string)<br/>    scale_down_mode              = optional(string)<br/>    temporary_name_for_rotation  = optional(string)<br/>    type                         = optional(string)<br/>    ultra_ssd_enabled            = optional(bool)<br/>    vnet_subnet_id               = optional(string)<br/>    zones                        = optional(list(string))<br/>    kubelet_config = optional(object({<br/>      allowed_unsafe_sysctls    = optional(list(string))<br/>      container_log_max_line    = optional(number)<br/>      container_log_max_size_mb = optional(number)<br/>      cpu_cfs_quota_enabled     = optional(bool)<br/>      cpu_cfs_quota_period      = optional(string)<br/>      cpu_manager_policy        = optional(string)<br/>      image_gc_high_threshold   = optional(number)<br/>      image_gc_low_threshold    = optional(number)<br/>      pod_max_pid               = optional(number)<br/>      topology_manager_policy   = optional(string)<br/>    }))<br/>    linux_os_config = optional(object({<br/>      swap_file_size_mb            = optional(number)<br/>      transparent_huge_page        = optional(string)<br/>      transparent_huge_page_defrag = optional(string)<br/>    }))<br/>    upgrade_settings = optional(object({<br/>      max_surge                     = string<br/>      drain_timeout_in_minutes      = optional(number)<br/>      node_soak_duration_in_minutes = optional(number)<br/>      undrainable_node_behavior     = optional(string)<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | value to set the dns prefix | `string` | `null` | no |
| <a name="input_dns_prefix_private_cluster"></a> [dns\_prefix\_private\_cluster](#input\_dns\_prefix\_private\_cluster) | value to set the dns prefix private cluster | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_image_cleaner_enabled"></a> [image\_cleaner\_enabled](#input\_image\_cleaner\_enabled) | value to set the image cleaner enabled | `bool` | `null` | no |
| <a name="input_image_cleaner_interval_hours"></a> [image\_cleaner\_interval\_hours](#input\_image\_cleaner\_interval\_hours) | value to set the image cleaner interval hours | `number` | `null` | no |
| <a name="input_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#input\_kubernetes\_cluster\_name) | value to set the kubernetes cluster name | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | value to set the kubernetes version | `string` | `null` | no |
| <a name="input_linux_profile"></a> [linux\_profile](#input\_linux\_profile) | value to set the linux profile | <pre>object({<br/>    admin_username = string<br/>    ssh_key = object({<br/>      key_data = string<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled) | value to set the local account disabled | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_microsoft_defender"></a> [microsoft\_defender](#input\_microsoft\_defender) | value to set the microsoft defender | <pre>object({<br/>    log_analytics_workspace_id = string<br/>  })</pre> | `null` | no |
| <a name="input_network_profile"></a> [network\_profile](#input\_network\_profile) | value to set the network profile | <pre>object({<br/>    network_plugin      = string<br/>    dns_service_ip      = optional(string)<br/>    load_balancer_sku   = optional(string)<br/>    network_data_plane  = optional(string)<br/>    network_mode        = optional(string)<br/>    network_plugin_mode = optional(string)<br/>    network_policy      = optional(string)<br/>    outbound_type       = optional(string)<br/>    pod_cidr            = optional(string)<br/>    pod_cidrs           = optional(list(string))<br/>    service_cidr        = optional(string)<br/>    service_cidrs       = optional(list(string))<br/>    advanced_networking = optional(object({<br/>      observability_enabled = optional(bool)<br/>      security_enabled      = optional(bool)<br/>    }))<br/>    load_balancer_profile = optional(object({<br/>      backend_pool_type           = optional(string)<br/>      idle_timeout_in_minutes     = optional(number)<br/>      managed_outbound_ip_count   = optional(number)<br/>      managed_outbound_ipv6_count = optional(number)<br/>      outbound_ip_address_ids     = optional(list(string))<br/>      outbound_ip_prefix_ids      = optional(list(string))<br/>      outbound_ports_allocated    = optional(number)<br/>    }))<br/>    nat_gateway_profile = optional(object({<br/>      idle_timeout_in_minutes   = optional(number)<br/>      managed_outbound_ip_count = optional(number)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_node_os_upgrade_channel"></a> [node\_os\_upgrade\_channel](#input\_node\_os\_upgrade\_channel) | value to set the node os upgrade channel | `string` | `null` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | value to set the oidc issuer enabled | `bool` | `null` | no |
| <a name="input_oms_agent"></a> [oms\_agent](#input\_oms\_agent) | value to set the oms agent | <pre>object({<br/>    log_analytics_workspace_id      = string<br/>    msi_auth_for_monitoring_enabled = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | value to set the private cluster enabled | `bool` | `null` | no |
| <a name="input_private_cluster_public_fqdn_enabled"></a> [private\_cluster\_public\_fqdn\_enabled](#input\_private\_cluster\_public\_fqdn\_enabled) | value to set the private cluster public fqdn enabled | `bool` | `null` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | value to set the private dns zone id | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | value to set the role based access control enabled | `bool` | `null` | no |
| <a name="input_run_command_enabled"></a> [run\_command\_enabled](#input\_run\_command\_enabled) | value to set the run command enabled | `bool` | `null` | no |
| <a name="input_service_principal"></a> [service\_principal](#input\_service\_principal) | value to set the service principal | <pre>object({<br/>    client_id     = string<br/>    client_secret = string<br/>  })</pre> | `null` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | value to set the sku tier | `string` | `null` | no |
| <a name="input_storage_profile"></a> [storage\_profile](#input\_storage\_profile) | value to set the storage profile | <pre>object({<br/>    blob_driver_enabled         = optional(bool)<br/>    disk_driver_enabled         = optional(bool)<br/>    file_driver_enabled         = optional(bool)<br/>    snapshot_controller_enabled = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_support_plan"></a> [support\_plan](#input\_support\_plan) | value to set the support plan | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_workload_autoscaler_profile"></a> [workload\_autoscaler\_profile](#input\_workload\_autoscaler\_profile) | value to set the workload autoscaler profile | <pre>object({<br/>    keda_enabled                    = optional(bool)<br/>    vertical_pod_autoscaler_enabled = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | value to set the workload identity enabled | `bool` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_current_kubernetes_version"></a> [current\_kubernetes\_version](#output\_current\_kubernetes\_version) | n/a |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT KUBERNETES CLUSTER ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | n/a |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | n/a |
| <a name="output_private_fqdn"></a> [private\_fqdn](#output\_private\_fqdn) | n/a |
<!-- END_TF_DOCS -->