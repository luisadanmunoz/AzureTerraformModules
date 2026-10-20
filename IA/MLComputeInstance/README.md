# Azure ML Compute Instance

Terraform module for creating Azure ML Compute Instances for development.

## Features

- Personal compute for data scientists
- SSH access support
- VNet integration
- User assignment

## Usage

```hcl
module "compute_instance" {
  source = "path/to/IA/MLComputeInstance"

  name                          = "ci-dev-001"
  machine_learning_workspace_id = module.ml_workspace.id
  virtual_machine_size          = "Standard_DS3_v2"
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
| name | Instance name | `string` | n/a | yes |
| machine_learning_workspace_id | ML Workspace ID | `string` | n/a | yes |
| virtual_machine_size | VM size | `string` | n/a | yes |
| node_public_ip_enabled | Public IP | `bool` | `true` | no |
| subnet_resource_id | Subnet ID | `string` | `null` | no |
| ssh | SSH config | `object` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The instance ID |
| name | The instance name |
