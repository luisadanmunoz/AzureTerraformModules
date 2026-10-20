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
| [azurerm_machine_learning_compute_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the compute cluster. | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of User Assigned Managed Identity IDs. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. | `string` | `"SystemAssigned"` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | Whether local authentication is enabled. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region. | `string` | n/a | yes |
| <a name="input_machine_learning_workspace_id"></a> [machine\_learning\_workspace\_id](#input\_machine\_learning\_workspace\_id) | The ID of the Machine Learning Workspace. | `string` | n/a | yes |
| <a name="input_max_node_count"></a> [max\_node\_count](#input\_max\_node\_count) | Maximum number of nodes. | `number` | `4` | no |
| <a name="input_min_node_count"></a> [min\_node\_count](#input\_min\_node\_count) | Minimum number of nodes. | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the compute cluster. | `string` | n/a | yes |
| <a name="input_node_public_ip_enabled"></a> [node\_public\_ip\_enabled](#input\_node\_public\_ip\_enabled) | Whether nodes have public IPs. | `bool` | `true` | no |
| <a name="input_scale_down_nodes_after_idle_duration"></a> [scale\_down\_nodes\_after\_idle\_duration](#input\_scale\_down\_nodes\_after\_idle\_duration) | Time before idle nodes are scaled down (ISO8601). | `string` | `"PT30M"` | no |
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH configuration. | <pre>object({<br/>    admin_username = string<br/>    admin_password = optional(string)<br/>    key_value      = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_ssh_public_access_enabled"></a> [ssh\_public\_access\_enabled](#input\_ssh\_public\_access\_enabled) | Whether SSH public access is enabled. | `bool` | `false` | no |
| <a name="input_subnet_resource_id"></a> [subnet\_resource\_id](#input\_subnet\_resource\_id) | The subnet resource ID for the cluster. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |
| <a name="input_vm_priority"></a> [vm\_priority](#input\_vm\_priority) | The priority of VMs. Possible values: Dedicated, LowPriority. | `string` | `"Dedicated"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The VM size for cluster nodes. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the compute cluster. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block. |
| <a name="output_name"></a> [name](#output\_name) | The name of the compute cluster. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned identity. |
<!-- END_TF_DOCS -->