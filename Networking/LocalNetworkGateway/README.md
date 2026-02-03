# Azure Local Network Gateway Terraform Module

This module creates an Azure Local Network Gateway, which represents your on-premises VPN device for site-to-site VPN connections.

## Features

- Automatic resource naming with configurable prefix, workload, environment, and instance
- Support for gateway IP address or FQDN
- On-premises address space configuration
- Optional BGP settings (ASN, peering address, peer weight)
- Conditional creation via `create` flag

## Usage

### Basic (IP Address)

```hcl
module "local_network_gateway" {
  source = "../../Networking/LocalNetworkGateway"

  resource_group_name = "rg-network-prod-001"
  location            = "westeurope"
  gateway_address     = "203.0.113.1"

  address_space = [
    "10.1.0.0/16",
    "10.2.0.0/16"
  ]
}
```

### With BGP Settings

```hcl
module "local_network_gateway" {
  source = "../../Networking/LocalNetworkGateway"

  resource_group_name = "rg-network-prod-001"
  location            = "westeurope"
  name                = "lgw-onprem-hq-001"
  gateway_address     = "203.0.113.1"

  address_space = ["10.1.0.0/16"]

  bgp_settings = {
    asn                 = 65010
    bgp_peering_address = "10.1.0.1"
    peer_weight         = 0
  }
}
```

### With FQDN

```hcl
module "local_network_gateway" {
  source = "../../Networking/LocalNetworkGateway"

  resource_group_name = "rg-network-prod-001"
  location            = "westeurope"
  gateway_fqdn        = "vpn.contoso.com"

  address_space = ["10.1.0.0/16"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Local Network Gateway | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit name for the Local Network Gateway | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"lgw"` | no |
| workload | Workload name | `string` | `"onprem"` | no |
| environment | Environment name | `string` | `"prod"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| gateway_address | Public IP of the on-premises VPN device | `string` | `null` | no |
| gateway_fqdn | FQDN of the on-premises VPN device | `string` | `null` | no |
| address_space | List of on-premises network CIDR ranges | `list(string)` | `[]` | no |
| bgp_settings | BGP settings for the on-premises device | `object({...})` | `null` | no |
| tags | Tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Local Network Gateway |
| name | The name of the Local Network Gateway |
