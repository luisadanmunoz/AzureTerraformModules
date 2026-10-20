# AKS

Terraform module for creating Azure Kubernetes Service clusters.

## Features

- Azure CNI or Kubenet networking
- Multiple node pools with autoscaling
- Spot node pools for cost savings
- Azure AD RBAC integration
- Private cluster support
- Container Insights (OMS Agent)
- Key Vault Secrets Provider (CSI)
- Application Gateway Ingress Controller
- Maintenance windows

## Usage

### Basic Cluster

```hcl
module "aks" {
  source = "./Containers/AKS"

  resource_group_name = "rg-aks-prod-001"
  location            = "westeurope"

  workload    = "app"
  environment = "prod"

  default_node_pool = {
    vm_size   = "Standard_D4s_v5"
    min_count = 2
    max_count = 5
  }
}
```

### Production Cluster with Azure CNI

```hcl
module "aks" {
  source = "./Containers/AKS"

  resource_group_name = "rg-aks-prod-001"
  location            = "westeurope"
  name                = "aks-production-001"

  sku_tier           = "Standard"
  kubernetes_version = "1.28"

  default_node_pool = {
    name           = "system"
    vm_size        = "Standard_D4s_v5"
    min_count      = 3
    max_count      = 5
    vnet_subnet_id = module.subnet_aks.id
    only_critical_addons_enabled = true
  }

  node_pools = [
    {
      name           = "workload"
      vm_size        = "Standard_D8s_v5"
      min_count      = 2
      max_count      = 10
      vnet_subnet_id = module.subnet_aks.id
    },
    {
      name           = "spot"
      vm_size        = "Standard_D4s_v5"
      priority       = "Spot"
      min_count      = 0
      max_count      = 5
      node_taints    = ["kubernetes.azure.com/scalesetpriority=spot:NoSchedule"]
    }
  ]

  azure_active_directory_role_based_access_control = {
    azure_rbac_enabled     = true
    admin_group_object_ids = ["00000000-0000-0000-0000-000000000000"]
  }

  oms_agent = {
    enabled                    = true
    log_analytics_workspace_id = module.log_analytics.id
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | Cluster name | `string` | `null` | no |
| kubernetes_version | K8s version | `string` | `null` | no |
| sku_tier | Free, Standard, Premium | `string` | `"Free"` | no |
| default_node_pool | Default node pool config | `object` | `{}` | no |
| node_pools | Additional node pools | `list(object)` | `[]` | no |
| network_profile | Network configuration | `object` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Cluster ID |
| name | Cluster name |
| fqdn | Cluster FQDN |
| kube_config_raw | Raw kubeconfig |
| node_resource_group | Node resource group |
| oidc_issuer_url | OIDC issuer URL |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_automatic_upgrade_channel"></a> [automatic\_upgrade\_channel](#input\_automatic\_upgrade\_channel) | (Optional) Upgrade channel. Values: none, patch, rapid, stable, node-image. | `string` | `"stable"` | no |
| <a name="input_azure_active_directory_role_based_access_control"></a> [azure\_active\_directory\_role\_based\_access\_control](#input\_azure\_active\_directory\_role\_based\_access\_control) | (Optional) Azure AD RBAC configuration.<br/>- azure\_rbac\_enabled: Enable Azure RBAC for Kubernetes. Default: true.<br/>- admin\_group\_object\_ids: Admin group IDs.<br/>- tenant\_id: Azure AD tenant ID. | <pre>object({<br/>    azure_rbac_enabled      = optional(bool, true)<br/>    admin_group_object_ids  = optional(list(string), [])<br/>    tenant_id               = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | (Optional) Enable Azure Policy add-on. Default: false. | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the AKS cluster. | `bool` | `true` | no |
| <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool) | (Required) Default node pool configuration.<br/>- name: Node pool name. Default: system.<br/>- vm\_size: VM size. Default: Standard\_D2s\_v5.<br/>- node\_count: Number of nodes (if autoscaling disabled).<br/>- min\_count: Minimum nodes (if autoscaling enabled).<br/>- max\_count: Maximum nodes (if autoscaling enabled).<br/>- enable\_auto\_scaling: Enable autoscaling. Default: true.<br/>- os\_disk\_size\_gb: OS disk size in GB.<br/>- os\_disk\_type: Managed, Ephemeral. Default: Managed.<br/>- os\_sku: Ubuntu, AzureLinux, Windows2019, Windows2022. Default: Ubuntu.<br/>- zones: Availability zones.<br/>- vnet\_subnet\_id: Subnet ID for nodes.<br/>- max\_pods: Max pods per node. Default: 30.<br/>- only\_critical\_addons\_enabled: Only schedule critical add-ons. | <pre>object({<br/>    name                         = optional(string, "system")<br/>    vm_size                      = optional(string, "Standard_D2s_v5")<br/>    node_count                   = optional(number, null)<br/>    min_count                    = optional(number, 1)<br/>    max_count                    = optional(number, 3)<br/>    enable_auto_scaling          = optional(bool, true)<br/>    os_disk_size_gb              = optional(number, 128)<br/>    os_disk_type                 = optional(string, "Managed")<br/>    os_sku                       = optional(string, "Ubuntu")<br/>    zones                        = optional(list(string), ["1", "2", "3"])<br/>    vnet_subnet_id               = optional(string, null)<br/>    max_pods                     = optional(number, 30)<br/>    only_critical_addons_enabled = optional(bool, false)<br/>    node_labels                  = optional(map(string), {})<br/>    node_taints                  = optional(list(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | (Optional) DNS prefix for the cluster. If not provided, uses the cluster name. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity configuration.<br/>- type: SystemAssigned, UserAssigned. Default: SystemAssigned.<br/>- identity\_ids: User Assigned Identity IDs. | <pre>object({<br/>    type         = optional(string, "SystemAssigned")<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_ingress_application_gateway"></a> [ingress\_application\_gateway](#input\_ingress\_application\_gateway) | (Optional) Application Gateway Ingress Controller configuration.<br/>- enabled: Enable AGIC. Default: false.<br/>- gateway\_id: Existing App Gateway ID.<br/>- subnet\_id: Subnet for new App Gateway. | <pre>object({<br/>    enabled    = optional(bool, false)<br/>    gateway_id = optional(string, null)<br/>    subnet_id  = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_key_vault_secrets_provider"></a> [key\_vault\_secrets\_provider](#input\_key\_vault\_secrets\_provider) | (Optional) Key Vault Secrets Provider configuration.<br/>- enabled: Enable secrets provider. Default: false.<br/>- secret\_rotation\_enabled: Enable secret rotation.<br/>- secret\_rotation\_interval: Rotation interval. | <pre>object({<br/>    enabled                  = optional(bool, false)<br/>    secret_rotation_enabled  = optional(bool, true)<br/>    secret_rotation_interval = optional(string, "2m")<br/>  })</pre> | `null` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | (Optional) Kubernetes version. If not specified, latest is used. | `string` | `null` | no |
| <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled) | (Optional) Disable local accounts. Default: false. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the AKS cluster should exist. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | (Optional) Maintenance window configuration.<br/>- allowed: List of allowed maintenance windows.<br/>- not\_allowed: List of disallowed maintenance windows. | <pre>object({<br/>    allowed = optional(list(object({<br/>      day   = string<br/>      hours = list(number)<br/>    })), [])<br/>    not_allowed = optional(list(object({<br/>      start = string<br/>      end   = string<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the AKS cluster. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'aks'. | `string` | `"aks"` | no |
| <a name="input_network_profile"></a> [network\_profile](#input\_network\_profile) | (Optional) Network profile configuration.<br/>- network\_plugin: azure, kubenet, none. Default: azure.<br/>- network\_plugin\_mode: overlay (for azure CNI overlay).<br/>- network\_policy: azure, calico. Default: azure.<br/>- dns\_service\_ip: DNS service IP.<br/>- service\_cidr: Service CIDR.<br/>- pod\_cidr: Pod CIDR (for kubenet).<br/>- outbound\_type: loadBalancer, userDefinedRouting, managedNATGateway.<br/>- load\_balancer\_sku: basic, standard. Default: standard. | <pre>object({<br/>    network_plugin      = optional(string, "azure")<br/>    network_plugin_mode = optional(string, null)<br/>    network_policy      = optional(string, "azure")<br/>    dns_service_ip      = optional(string, null)<br/>    service_cidr        = optional(string, null)<br/>    pod_cidr            = optional(string, null)<br/>    outbound_type       = optional(string, "loadBalancer")<br/>    load_balancer_sku   = optional(string, "standard")<br/>  })</pre> | `{}` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | (Optional) Additional node pools. | <pre>list(object({<br/>    name                 = string<br/>    vm_size              = optional(string, "Standard_D2s_v5")<br/>    node_count           = optional(number, null)<br/>    min_count            = optional(number, 1)<br/>    max_count            = optional(number, 3)<br/>    enable_auto_scaling  = optional(bool, true)<br/>    os_disk_size_gb      = optional(number, 128)<br/>    os_disk_type         = optional(string, "Managed")<br/>    os_type              = optional(string, "Linux")<br/>    zones                = optional(list(string), ["1", "2", "3"])<br/>    vnet_subnet_id       = optional(string, null)<br/>    max_pods             = optional(number, 30)<br/>    mode                 = optional(string, "User")<br/>    node_labels          = optional(map(string), {})<br/>    node_taints          = optional(list(string), [])<br/>    priority             = optional(string, "Regular")<br/>    spot_max_price       = optional(number, -1)<br/>    eviction_policy      = optional(string, "Delete")<br/>  }))</pre> | `[]` | no |
| <a name="input_oms_agent"></a> [oms\_agent](#input\_oms\_agent) | (Optional) OMS Agent (Container Insights) configuration.<br/>- enabled: Enable OMS agent. Default: false.<br/>- log\_analytics\_workspace\_id: Log Analytics Workspace ID. | <pre>object({<br/>    enabled                    = optional(bool, false)<br/>    log_analytics_workspace_id = string<br/>  })</pre> | `null` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | (Optional) Enable private cluster. Default: false. | `bool` | `false` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | (Optional) Private DNS Zone ID for private cluster. DEPENDENCY: Private DNS Zone must exist. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) SKU tier. Values: Free, Standard, Premium. Default: Free. | `string` | `"Free"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"app"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | The client certificate for authentication. |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | The client key for authentication. |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | The cluster CA certificate. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the AKS cluster. |
| <a name="output_host"></a> [host](#output\_host) | The Kubernetes API server host. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the AKS cluster. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity of the AKS cluster. |
| <a name="output_kube_admin_config"></a> [kube\_admin\_config](#output\_kube\_admin\_config) | The admin Kubernetes config. |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | The Kubernetes config for the cluster. |
| <a name="output_kube_config_raw"></a> [kube\_config\_raw](#output\_kube\_config\_raw) | The raw Kubernetes config. |
| <a name="output_kubelet_identity"></a> [kubelet\_identity](#output\_kubelet\_identity) | The kubelet identity of the AKS cluster. |
| <a name="output_name"></a> [name](#output\_name) | The name of the AKS cluster. |
| <a name="output_node_pool_ids"></a> [node\_pool\_ids](#output\_node\_pool\_ids) | IDs of additional node pools. |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | The auto-generated resource group for nodes. |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | The OIDC issuer URL for workload identity. |
| <a name="output_private_fqdn"></a> [private\_fqdn](#output\_private\_fqdn) | The private FQDN of the AKS cluster (if private). |
<!-- END_TF_DOCS -->