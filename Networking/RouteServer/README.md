# Azure Route Server Terraform Module

This module creates an Azure Route Server with optional Public IP creation and BGP connection configuration.

## Features

- Automatic Public IP creation (or bring your own)
- Branch-to-branch traffic control
- BGP connection (peering) management with NVAs
- Flexible naming convention
- Standard SKU support

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist before creating the Route Server |
| Virtual Network | **Yes** | Must contain a subnet named `RouteServerSubnet` |
| RouteServerSubnet | **Yes** | Subnet named exactly `RouteServerSubnet` with a minimum /27 prefix |
| Public IP | No | If providing an existing Public IP (must be Standard SKU, Static allocation) |

## Usage

### Basic Example (Auto-creates Public IP)

```hcl
module "route_server" {
  source = "../../Networking/RouteServer"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  subnet_id           = azurerm_subnet.route_server.id

  name = "rs-hub-dev-001"
}
```

### With BGP Connections

```hcl
module "route_server" {
  source = "../../Networking/RouteServer"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"
  subnet_id           = azurerm_subnet.route_server.id

  name                             = "rs-hub-prod-001"
  branch_to_branch_traffic_enabled = true

  bgp_connections = [
    {
      name     = "nva-primary"
      peer_asn = 65001
      peer_ip  = "10.0.1.4"
    },
    {
      name     = "nva-secondary"
      peer_asn = 65001
      peer_ip  = "10.0.1.5"
    }
  ]
}
```

### With Existing Public IP

```hcl
module "route_server" {
  source = "../../Networking/RouteServer"

  resource_group_name  = "rg-networking-prod-001"
  location             = "westeurope"
  subnet_id            = azurerm_subnet.route_server.id
  public_ip_address_id = azurerm_public_ip.route_server.id

  name = "rs-hub-prod-001"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit name | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"rs"` | no |
| name_suffix | Suffix for generated name | `string` | `""` | no |
| workload | Workload name | `string` | `"default"` | no |
| environment | Environment name | `string` | `"dev"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| sku | SKU (Standard only) | `string` | `"Standard"` | no |
| subnet_id | RouteServerSubnet ID | `string` | n/a | **yes** |
| public_ip_address_id | Existing Public IP ID | `string` | `null` | no |
| branch_to_branch_traffic_enabled | Enable branch-to-branch | `bool` | `false` | no |
| bgp_connections | BGP peering connections | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Route Server |
| name | The name of the Route Server |
| virtual_router_asn | The ASN of the virtual router |
| virtual_router_ips | The BGP peering IP addresses of the virtual router |
| public_ip_id | Created Public IP ID (if created by module) |
| public_ip_address | Created Public IP address (if created by module) |

## Notes

- The Route Server must be deployed into a subnet named exactly `RouteServerSubnet`
- The `RouteServerSubnet` requires a minimum prefix of /27
- Route Server uses ASN 65515 by default (assigned by Azure, not configurable)
- Each Route Server supports up to 8 BGP connections
- Branch-to-branch traffic enables transit between VPN/ExpressRoute gateways via Route Server
