# DedicatedHost

Terraform module for creating Azure Dedicated Hosts.

## Features

- Various SKU types (DSv3, ESv3, etc.)
- Fault domain placement
- Auto-replace on failure
- Windows Server licensing

## Usage

```hcl
module "dedicated_host" {
  source = "./Compute/DedicatedHost"

  resource_group_name     = "rg-compute-prod-001"
  location                = "westeurope"
  dedicated_host_group_id = module.host_group.id

  workload    = "sap"
  environment = "prod"

  sku_name              = "DSv3-Type1"
  platform_fault_domain = 0
  license_type          = "Windows_Server_Hybrid"
}

# Use with VMs
module "vm" {
  source = "./Compute/VirtualMachine"
  dedicated_host_id = module.dedicated_host.id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dedicated_host_group_id | Parent Host Group | `string` | n/a | yes |
| sku_name | Host SKU | `string` | n/a | yes |
| platform_fault_domain | Fault domain | `number` | `0` | no |
| auto_replace_on_failure | Auto replace | `bool` | `true` | no |
| license_type | Windows licensing | `string` | `"None"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Dedicated Host ID |
| name | Dedicated Host name |

## Common SKUs

- `DSv3-Type1`, `DSv3-Type2` - D-series
- `ESv3-Type1`, `ESv3-Type2` - E-series
- `FSv2-Type2` - F-series
- `MSv2-Type1` - M-series (memory optimized)
