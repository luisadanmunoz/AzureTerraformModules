# Azure VPN Gateway Terraform Module

This module creates an Azure VPN Gateway or ExpressRoute Gateway with support for active-active, BGP, and Point-to-Site VPN configurations.

## Features

- VPN and ExpressRoute gateway types
- RouteBased and PolicyBased VPN
- Zone-redundant SKUs
- Active-active mode
- BGP configuration
- Point-to-Site VPN (Certificate, RADIUS, Azure AD)
- Generation 1 and 2 support
- Diagnostic settings

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| GatewaySubnet | **Yes** | Subnet named exactly "GatewaySubnet" with minimum /27 |
| Public IP | No | Created automatically if not provided |

## Usage

### Basic VPN Gateway

```hcl
module "vpn_gateway" {
  source = "../../Networking/VPNGateway"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"
  subnet_id           = azurerm_subnet.gateway.id

  name       = "vpngw-hub-prod-001"
  sku        = "VpnGw1AZ"
  generation = "Generation1"
}
```

### Active-Active with BGP

```hcl
module "vpn_gateway" {
  source = "../../Networking/VPNGateway"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"
  subnet_id           = azurerm_subnet.gateway.id

  name          = "vpngw-hub-prod-001"
  sku           = "VpnGw2AZ"
  active_active = true
  enable_bgp    = true

  bgp_settings = {
    asn = 65515
  }
}
```

### Point-to-Site with Azure AD

```hcl
module "vpn_gateway" {
  source = "../../Networking/VPNGateway"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"
  subnet_id           = azurerm_subnet.gateway.id

  name = "vpngw-hub-prod-001"
  sku  = "VpnGw1AZ"

  vpn_client_configuration = {
    address_space        = ["172.16.0.0/24"]
    vpn_client_protocols = ["OpenVPN"]
    vpn_auth_types       = ["AAD"]
    aad_tenant           = "https://login.microsoftonline.com/tenant-id/"
    aad_audience         = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
    aad_issuer           = "https://sts.windows.net/tenant-id/"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| subnet_id | GatewaySubnet ID | `string` | n/a | **yes** |
| name | Gateway name | `string` | auto | no |
| type | Vpn or ExpressRoute | `string` | `"Vpn"` | no |
| vpn_type | RouteBased or PolicyBased | `string` | `"RouteBased"` | no |
| sku | Gateway SKU | `string` | `"VpnGw1AZ"` | no |
| generation | Generation1 or Generation2 | `string` | `"Generation2"` | no |
| active_active | Enable active-active | `bool` | `false` | no |
| enable_bgp | Enable BGP | `bool` | `false` | no |
| bgp_settings | BGP configuration | `object({...})` | `null` | no |
| vpn_client_configuration | P2S configuration | `object({...})` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Gateway ID |
| name | Gateway name |
| public_ip_address | Primary public IP |
| public_ip_address_secondary | Secondary public IP |
| bgp_peering_address | BGP peering addresses |
| bgp_asn | BGP ASN |

## Notes

- Gateway deployment takes 30-45 minutes
- GatewaySubnet requires minimum /27 (/26 recommended)
- Zone-redundant SKUs require Standard SKU Public IPs
- Active-active requires two Public IPs
