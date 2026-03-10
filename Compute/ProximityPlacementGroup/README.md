# ProximityPlacementGroup

Terraform module for creating Azure Proximity Placement Groups.

## Features

- Low-latency VM placement
- Allowed VM sizes filtering
- Zone-specific placement
- Conditional creation

## Usage

```hcl
module "ppg" {
  source = "./Compute/ProximityPlacementGroup"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"

  workload    = "hpc"
  environment = "prod"

  allowed_vm_sizes = ["Standard_D4s_v5", "Standard_D8s_v5"]
  zone             = "1"
}

# Use with VirtualMachine module
module "vm" {
  source = "./Compute/VirtualMachine"

  proximity_placement_group_id = module.ppg.id
  zone                         = "1"
  # ... other VM config
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
| create | Controls creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | PPG name | `string` | `null` | no |
| allowed_vm_sizes | Allowed VM sizes | `list(string)` | `[]` | no |
| zone | Availability Zone | `string` | `null` | no |
| tags | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The PPG ID |
| name | The PPG name |

## Notes

- Use for HPC, SAP, or latency-sensitive workloads
- VMs in PPG are physically closer together
- Consider combining with Availability Sets
