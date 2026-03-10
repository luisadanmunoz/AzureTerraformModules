# Azure ExpressRoute Circuit Terraform Module

This module creates an Azure ExpressRoute Circuit with support for peering configurations, ExpressRoute Direct, and diagnostic settings.

## Features

- Standard and Premium tier circuits
- MeteredData and UnlimitedData billing models
- Azure Private, Public, and Microsoft peering
- ExpressRoute Direct support (via express_route_port_id)
- Microsoft peering configuration with advertised prefixes
- Diagnostic settings (Log Analytics, Storage Account, Event Hub)
- Conditional creation with `create` flag

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| ExpressRoute Port | No | Required only for ExpressRoute Direct |

## Usage

### Basic ExpressRoute Circuit

```hcl
module "expressroute" {
  source = "../../Networking/ExpressRoute"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"

  name                  = "erc-hub-prod-001"
  service_provider_name = "Equinix"
  peering_location      = "Amsterdam"
  bandwidth_in_mbps     = 200

  sku_tier   = "Standard"
  sku_family = "MeteredData"
}
```

### Premium Circuit with Private Peering

```hcl
module "expressroute" {
  source = "../../Networking/ExpressRoute"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"

  name                  = "erc-hub-prod-001"
  service_provider_name = "Equinix"
  peering_location      = "Amsterdam"
  bandwidth_in_mbps     = 1000

  sku_tier   = "Premium"
  sku_family = "UnlimitedData"

  peerings = [
    {
      peering_type                  = "AzurePrivatePeering"
      vlan_id                       = 100
      primary_peer_address_prefix   = "10.0.0.0/30"
      secondary_peer_address_prefix = "10.0.0.4/30"
      peer_asn                      = 65000
    }
  ]
}
```

### Circuit with Microsoft Peering

```hcl
module "expressroute" {
  source = "../../Networking/ExpressRoute"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"

  name                  = "erc-hub-prod-001"
  service_provider_name = "Equinix"
  peering_location      = "Amsterdam"
  bandwidth_in_mbps     = 500

  sku_tier   = "Premium"
  sku_family = "MeteredData"

  peerings = [
    {
      peering_type                  = "MicrosoftPeering"
      vlan_id                       = 200
      primary_peer_address_prefix   = "123.0.0.0/30"
      secondary_peer_address_prefix = "123.0.0.4/30"
      peer_asn                      = 65000
      microsoft_peering_config = {
        advertised_public_prefixes = ["123.1.0.0/24"]
      }
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create resources | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit circuit name | `string` | auto | no |
| name_prefix | Prefix for generated name | `string` | `"erc"` | no |
| workload | Workload name | `string` | `"hub"` | no |
| environment | Environment name | `string` | `"prod"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| service_provider_name | ExpressRoute service provider | `string` | n/a | **yes** |
| peering_location | ExpressRoute peering location | `string` | n/a | **yes** |
| bandwidth_in_mbps | Bandwidth in Mbps | `number` | n/a | **yes** |
| sku_tier | Standard or Premium | `string` | `"Standard"` | no |
| sku_family | MeteredData or UnlimitedData | `string` | `"MeteredData"` | no |
| allow_classic_operations | Allow classic operations | `bool` | `false` | no |
| express_route_port_id | ExpressRoute Port ID for Direct | `string` | `null` | no |
| bandwidth_in_gbps | Bandwidth in Gbps for Direct | `number` | `null` | no |
| authorization_key | Authorization key | `string` | `null` | no |
| peerings | List of peering configurations | `list(object({...}))` | `[]` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |
| diagnostic_settings | Diagnostic settings | `object({...})` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ExpressRoute Circuit ID |
| name | ExpressRoute Circuit name |
| service_key | ExpressRoute Circuit service key (sensitive) |
| service_provider_provisioning_state | Provisioning state with the service provider |

## Notes

- The `service_key` output is marked as sensitive and is used to provision the circuit with the service provider.
- When using ExpressRoute Direct (`express_route_port_id`), `service_provider_name`, `peering_location`, and `bandwidth_in_mbps` are not used; use `bandwidth_in_gbps` instead.
- Circuit provisioning with the service provider is an out-of-band process that takes additional time after Terraform deployment.
- Microsoft peering requires verified public IP prefixes.
