# Azure VNet Peering Terraform Module

This module creates VNet Peering between two Azure Virtual Networks with optional bidirectional configuration.

## Features

- Unidirectional and bidirectional peering
- Gateway transit support for hub-spoke topologies
- Traffic forwarding configuration
- Subnet-level peering (optional)
- Cross-subscription peering support
- Auto-generated peering names

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group (Local) | **Yes** | Contains the local VNet |
| Virtual Network (Local) | **Yes** | Source VNet for peering |
| Virtual Network (Remote) | **Yes** | Target VNet for peering |
| VNet Gateway | No | Required if using gateway transit |
| Resource Group (Remote) | No | Only for bidirectional peering |

## Usage

### Basic Peering (Unidirectional)

```hcl
module "peering" {
  source = "../../Networking/VNetPeering"

  resource_group_name       = "rg-spoke-dev-001"
  virtual_network_name      = "vnet-spoke-dev-001"
  remote_virtual_network_id = "/subscriptions/.../virtualNetworks/vnet-hub-dev-001"
}
```

### Bidirectional Peering

```hcl
module "peering" {
  source = "../../Networking/VNetPeering"

  resource_group_name       = "rg-spoke-dev-001"
  virtual_network_name      = "vnet-spoke-dev-001"
  remote_virtual_network_id = module.hub_vnet.id

  # Enable bidirectional peering
  create_reverse_peering              = true
  reverse_peering_resource_group_name = "rg-hub-dev-001"
}
```

### Hub-Spoke with Gateway Transit

```hcl
# Hub side (has the VPN Gateway)
module "hub_to_spoke_peering" {
  source = "../../Networking/VNetPeering"

  resource_group_name       = "rg-hub-prod-001"
  virtual_network_name      = "vnet-hub-prod-001"
  remote_virtual_network_id = module.spoke_vnet.id

  allow_gateway_transit   = true  # Hub allows spoke to use its gateway
  allow_forwarded_traffic = true
}

# Spoke side (uses hub's gateway)
module "spoke_to_hub_peering" {
  source = "../../Networking/VNetPeering"

  resource_group_name       = "rg-spoke-prod-001"
  virtual_network_name      = "vnet-spoke-prod-001"
  remote_virtual_network_id = module.hub_vnet.id

  use_remote_gateways     = true  # Spoke uses hub's gateway
  allow_forwarded_traffic = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Local RG name | `string` | n/a | **yes** |
| virtual_network_name | Local VNet name | `string` | n/a | **yes** |
| remote_virtual_network_id | Remote VNet ID | `string` | n/a | **yes** |
| name | Peering name | `string` | auto | no |
| allow_virtual_network_access | Allow VM access | `bool` | `true` | no |
| allow_forwarded_traffic | Allow NVA traffic | `bool` | `false` | no |
| allow_gateway_transit | Allow gateway usage | `bool` | `false` | no |
| use_remote_gateways | Use remote gateway | `bool` | `false` | no |
| create_reverse_peering | Create bidirectional | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Peering ID |
| name | Peering name |
| reverse_peering_id | Reverse peering ID |
| reverse_peering_name | Reverse peering name |

## Important Notes

- Peering is non-transitive (spoke-to-spoke requires explicit peering or NVA)
- `use_remote_gateways` cannot be true if local VNet has a gateway
- Gateway transit requires VPN/ExpressRoute Gateway deployed
- Cross-subscription peering requires appropriate RBAC permissions
