# Azure VPN Connection Terraform Module

This module creates an Azure Virtual Network Gateway Connection with support for Site-to-Site (IPsec), VNet-to-VNet, and ExpressRoute connection types.

## Features

- Site-to-Site (IPsec) connections
- VNet-to-VNet connections
- ExpressRoute connections
- Custom IPsec/IKE policy
- Traffic selector policies
- BGP support
- Dead Peer Detection (DPD) timeout
- Policy-based traffic selectors

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Virtual Network Gateway | **Yes** | Must exist |
| Local Network Gateway | Conditional | Required for IPsec connections |
| Peer Virtual Network Gateway | Conditional | Required for Vnet2Vnet connections |
| ExpressRoute Circuit | Conditional | Required for ExpressRoute connections |

## Usage

### Basic Site-to-Site VPN Connection

```hcl
module "vpn_connection" {
  source = "../../Networking/VPNConnection"

  resource_group_name        = "rg-hub-prod-001"
  location                   = "westeurope"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.hub.id
  local_network_gateway_id   = azurerm_local_network_gateway.onprem.id

  name       = "vcn-hub-prod-001"
  type       = "IPsec"
  shared_key = "YourSharedSecretKey"
}
```

### VNet-to-VNet Connection

```hcl
module "vpn_connection" {
  source = "../../Networking/VPNConnection"

  resource_group_name         = "rg-hub-prod-001"
  location                    = "westeurope"
  virtual_network_gateway_id  = azurerm_virtual_network_gateway.hub.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.spoke.id

  name       = "vcn-hub-to-spoke-prod-001"
  type       = "Vnet2Vnet"
  shared_key = "YourSharedSecretKey"
}
```

### IPsec Connection with Custom Policy

```hcl
module "vpn_connection" {
  source = "../../Networking/VPNConnection"

  resource_group_name        = "rg-hub-prod-001"
  location                   = "westeurope"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.hub.id
  local_network_gateway_id   = azurerm_local_network_gateway.onprem.id

  name                = "vcn-hub-prod-001"
  type                = "IPsec"
  shared_key          = "YourSharedSecretKey"
  connection_protocol = "IKEv2"

  ipsec_policy = {
    dh_group         = "DHGroup14"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "AES256"
    ipsec_integrity  = "SHA256"
    pfs_group        = "PFS2048"
    sa_lifetime      = 27000
    sa_datasize      = 102400000
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the VPN Connection | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| virtual_network_gateway_id | Virtual Network Gateway ID | `string` | n/a | **yes** |
| name | Connection name | `string` | auto | no |
| name_prefix | Prefix for generated name | `string` | `"vcn"` | no |
| workload | Workload name | `string` | `"hub"` | no |
| environment | Environment name | `string` | `"prod"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| type | IPsec, Vnet2Vnet, or ExpressRoute | `string` | n/a | **yes** |
| peer_virtual_network_gateway_id | Peer VPN Gateway ID (Vnet2Vnet) | `string` | `null` | no |
| local_network_gateway_id | Local Network Gateway ID (IPsec) | `string` | `null` | no |
| express_route_circuit_id | ExpressRoute Circuit ID | `string` | `null` | no |
| shared_key | Shared IPSec key | `string` | `null` | no |
| connection_protocol | IKEv1 or IKEv2 | `string` | `null` | no |
| enable_bgp | Enable BGP | `bool` | `false` | no |
| dpd_timeout_seconds | Dead Peer Detection timeout | `number` | `null` | no |
| use_policy_based_traffic_selectors | Enable policy-based traffic selectors | `bool` | `false` | no |
| ipsec_policy | IPsec policy configuration | `object({...})` | `null` | no |
| traffic_selector_policy | Traffic selector policies | `list(object({...}))` | `[]` | no |
| tags | Tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the VPN Connection |
| name | The name of the VPN Connection |

## Notes

- IPsec connections require a Local Network Gateway and shared key
- Vnet2Vnet connections require a peer Virtual Network Gateway and shared key
- ExpressRoute connections require an ExpressRoute Circuit
- Custom IPsec policies override the default Azure negotiation parameters
- Traffic selector policies are used with policy-based traffic selectors enabled
