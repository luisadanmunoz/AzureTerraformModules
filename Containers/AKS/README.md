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
