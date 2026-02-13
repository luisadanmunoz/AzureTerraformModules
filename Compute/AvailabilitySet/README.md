# AvailabilitySet

Terraform module for creating Azure Availability Sets.

## Features

- Configurable fault and update domains
- Proximity Placement Group integration
- Managed disk support
- Conditional creation with `create` flag

## Usage

```hcl
module "availability_set" {
  source = "./Compute/AvailabilitySet"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"

  workload    = "web"
  environment = "prod"

  platform_fault_domain_count  = 3
  platform_update_domain_count = 5
}

# Use with VirtualMachine module
module "vm" {
  source = "./Compute/VirtualMachine"

  availability_set_id = module.availability_set.id
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
| name | Availability Set name | `string` | `null` | no |
| platform_fault_domain_count | Fault domains (2-3) | `number` | `2` | no |
| platform_update_domain_count | Update domains (1-20) | `number` | `5` | no |
| proximity_placement_group_id | PPG ID | `string` | `null` | no |
| managed | Use managed disks | `bool` | `true` | no |
| tags | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Availability Set ID |
| name | The Availability Set name |
| platform_fault_domain_count | Fault domains |
| platform_update_domain_count | Update domains |

## Notes

- Cannot be used with Availability Zones (use zones directly on VMs instead)
- Max fault domains varies by region (2 or 3)
- VMs must use managed disks when `managed = true`
