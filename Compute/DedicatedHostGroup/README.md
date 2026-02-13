# DedicatedHostGroup

Terraform module for creating Azure Dedicated Host Groups.

## Features

- Fault domain configuration
- Availability Zone placement
- Automatic VM placement
- Conditional creation

## Usage

```hcl
module "host_group" {
  source = "./Compute/DedicatedHostGroup"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"

  workload    = "sap"
  environment = "prod"

  platform_fault_domain_count = 2
  zone                        = "1"
  automatic_placement_enabled = true
}

# Then add hosts
module "host" {
  source = "./Compute/DedicatedHost"
  dedicated_host_group_id = module.host_group.id
  sku_name                = "DSv3-Type1"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| platform_fault_domain_count | Fault domains (1-3) | `number` | n/a | yes |
| zone | Availability Zone | `string` | `null` | no |
| automatic_placement_enabled | Auto place VMs | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Host Group ID |
| name | Host Group name |
