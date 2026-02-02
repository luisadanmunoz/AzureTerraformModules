# Azure Route Table Terraform Module

This module creates an Azure Route Table with configurable routes for custom routing scenarios.

## Features

- Custom routes with various next hop types
- BGP route propagation control
- Virtual Appliance (NVA/Firewall) routing support
- Flexible naming convention
- `create` flag for conditional creation

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist before creating the Route Table |
| Network Virtual Appliance | No | Only if using VirtualAppliance next hop type |
| Azure Firewall | No | Only if routing traffic through Azure Firewall |

## Usage

### Basic Example

```hcl
module "route_table" {
  source = "../../Networking/RouteTable"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name = "rt-spoke-dev-001"
}
```

### Force Traffic Through Firewall

```hcl
module "route_table" {
  source = "../../Networking/RouteTable"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"

  name                          = "rt-spoke-prod-001"
  bgp_route_propagation_enabled = false

  routes = {
    "to-internet" = {
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.0.4"  # Azure Firewall private IP
    }
    "to-onprem" = {
      address_prefix         = "192.168.0.0/16"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.0.4"
    }
  }
}
```

### Block Internet Access

```hcl
module "route_table" {
  source = "../../Networking/RouteTable"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  name                = "rt-isolated-dev-001"

  routes = {
    "block-internet" = {
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "None"
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit name | `string` | `null` | no |
| bgp_route_propagation_enabled | Enable BGP propagation | `bool` | `true` | no |
| routes | Map of routes | `map(object({...}))` | `{}` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Route Table |
| name | The name of the Route Table |
| route_ids | Map of route names to IDs |
| routes | Map of route configurations |

## Next Hop Types

| Type | Description |
|------|-------------|
| `VirtualNetworkGateway` | Route to VPN/ExpressRoute Gateway |
| `VnetLocal` | Route within the VNet |
| `Internet` | Route to Internet |
| `VirtualAppliance` | Route to NVA/Firewall (requires IP) |
| `None` | Drop traffic (blackhole) |

## Security Recommendations

1. **Disable BGP propagation** when using forced tunneling
2. **Use Azure Firewall** or NVA for internet-bound traffic inspection
3. **Document all routes** for compliance and troubleshooting
