# Azure NAT Gateway Terraform Module

This module creates an Azure NAT Gateway with optional Public IP creation and associations.

## Features

- Automatic Public IP creation (optional)
- Public IP and Public IP Prefix associations
- Zone configuration
- Idle timeout configuration
- Flexible naming convention

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist before creating the NAT Gateway |
| Public IP | No | If providing existing IPs (must be Standard SKU, Static) |
| Public IP Prefix | No | If using IP prefixes for SNAT |
| Subnet | No | Subnet association done via Subnet module |

## Usage

### Basic Example (Auto-creates Public IP)

```hcl
module "nat_gateway" {
  source = "../../Networking/NATGateway"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name = "ng-spoke-dev-001"
}
```

### With Existing Public IPs

```hcl
module "nat_gateway" {
  source = "../../Networking/NATGateway"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"

  name             = "ng-spoke-prod-001"
  create_public_ip = false
  public_ip_ids    = [module.pip1.id, module.pip2.id]
}
```

### Zone-Specific

```hcl
module "nat_gateway" {
  source = "../../Networking/NATGateway"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"

  name  = "ng-zone1-prod-001"
  zones = ["1"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit name | `string` | `null` | no |
| sku_name | SKU name (Standard only) | `string` | `"Standard"` | no |
| idle_timeout_in_minutes | Idle timeout (4-120) | `number` | `4` | no |
| zones | Availability zones (single) | `list(string)` | `[]` | no |
| create_public_ip | Create a Public IP | `bool` | `true` | no |
| public_ip_ids | Existing Public IP IDs | `list(string)` | `[]` | no |
| public_ip_prefix_ids | Public IP Prefix IDs | `list(string)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the NAT Gateway |
| name | The name of the NAT Gateway |
| resource_guid | The resource GUID |
| public_ip_id | Created Public IP ID |
| public_ip_address | Created Public IP address |
| all_public_ip_ids | All associated Public IP IDs |

## Notes

- NAT Gateway only supports a single availability zone
- Public IPs must be Standard SKU with Static allocation
- Associate NAT Gateway to subnets using the Subnet module
- Each NAT Gateway supports up to 16 Public IPs
