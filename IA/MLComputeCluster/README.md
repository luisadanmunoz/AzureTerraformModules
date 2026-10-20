# Azure ML Compute Cluster

Terraform module for creating Azure ML Compute Clusters for training.

## Features

- Auto-scaling compute cluster
- Dedicated or Low Priority VMs
- VNet integration
- System and User Assigned Identity

## Usage

```hcl
module "compute_cluster" {
  source = "path/to/IA/MLComputeCluster"

  name                          = "cc-training-001"
  machine_learning_workspace_id = module.ml_workspace.id
  location                      = "westeurope"
  vm_size                       = "Standard_DS3_v2"
  vm_priority                   = "Dedicated"

  min_node_count = 0
  max_node_count = 4
}
```

### GPU Cluster for Deep Learning

```hcl
module "gpu_cluster" {
  source = "path/to/IA/MLComputeCluster"

  name                          = "cc-gpu-001"
  machine_learning_workspace_id = module.ml_workspace.id
  location                      = "westeurope"
  vm_size                       = "Standard_NC6"
  vm_priority                   = "LowPriority"

  min_node_count = 0
  max_node_count = 8
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
| name | Cluster name | `string` | n/a | yes |
| machine_learning_workspace_id | ML Workspace ID | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| vm_size | VM size | `string` | n/a | yes |
| vm_priority | Dedicated/LowPriority | `string` | `"Dedicated"` | no |
| min_node_count | Minimum nodes | `number` | `0` | no |
| max_node_count | Maximum nodes | `number` | `4` | no |
| subnet_resource_id | Subnet ID | `string` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The cluster ID |
| name | The cluster name |
| principal_id | System identity principal ID |
