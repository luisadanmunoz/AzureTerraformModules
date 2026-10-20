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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_express_route_circuit.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit) | resource |
| [azurerm_express_route_circuit_peering.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_peering) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allow_classic_operations"></a> [allow\_classic\_operations](#input\_allow\_classic\_operations) | (Optional) Allow classic operations for the ExpressRoute circuit. | `bool` | `false` | no |
| <a name="input_authorization_key"></a> [authorization\_key](#input\_authorization\_key) | (Optional) The authorization key for the ExpressRoute circuit. | `string` | `null` | no |
| <a name="input_bandwidth_in_gbps"></a> [bandwidth\_in\_gbps](#input\_bandwidth\_in\_gbps) | (Optional) The bandwidth in Gbps when using ExpressRoute Direct. | `number` | `null` | no |
| <a name="input_bandwidth_in_mbps"></a> [bandwidth\_in\_mbps](#input\_bandwidth\_in\_mbps) | (Required) The bandwidth in Mbps for the ExpressRoute circuit (e.g. 50, 100, 200, 500, 1000). | `number` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the ExpressRoute Circuit. | `bool` | `true` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration. | <pre>object({<br/>    name                           = optional(string, "diag-expressroute")<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    log_categories = optional(list(string), [<br/>      "PeeringRouteLog"<br/>    ])<br/>    metric_categories = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_express_route_port_id"></a> [express\_route\_port\_id](#input\_express\_route\_port\_id) | (Optional) The ID of the ExpressRoute Port resource when using ExpressRoute Direct. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the ExpressRoute Circuit. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"erc"` | no |
| <a name="input_peering_location"></a> [peering\_location](#input\_peering\_location) | (Required) The peering location for the ExpressRoute circuit (e.g. Silicon Valley, Washington DC). | `string` | n/a | yes |
| <a name="input_peerings"></a> [peerings](#input\_peerings) | (Optional) List of peering configurations for the ExpressRoute circuit.<br/><br/>Attributes:<br/>  - peering\_type: AzurePrivatePeering, AzurePublicPeering, or MicrosoftPeering.<br/>  - vlan\_id: VLAN ID for the peering.<br/>  - primary\_peer\_address\_prefix: /30 subnet for the primary link.<br/>  - secondary\_peer\_address\_prefix: /30 subnet for the secondary link.<br/>  - peer\_asn: Peer BGP ASN.<br/>  - shared\_key: (Optional) Pre-shared key for the peering.<br/>  - microsoft\_peering\_config: (Optional) Microsoft peering configuration. | <pre>list(object({<br/>    peering_type                  = string<br/>    vlan_id                       = number<br/>    primary_peer_address_prefix   = string<br/>    secondary_peer_address_prefix = string<br/>    peer_asn                      = optional(number, null)<br/>    shared_key                    = optional(string, null)<br/>    microsoft_peering_config = optional(object({<br/>      advertised_public_prefixes = list(string)<br/>      customer_asn               = optional(number, 0)<br/>      routing_registry_name      = optional(string, "NONE")<br/>      advertised_communities     = optional(list(string), null)<br/>    }), null)<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_service_provider_name"></a> [service\_provider\_name](#input\_service\_provider\_name) | (Required) The name of the ExpressRoute service provider (e.g. Equinix, AT&T, Verizon). | `string` | n/a | yes |
| <a name="input_sku_family"></a> [sku\_family](#input\_sku\_family) | (Optional) The billing model for the ExpressRoute circuit: MeteredData or UnlimitedData. | `string` | `"MeteredData"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) The service tier for the ExpressRoute circuit: Standard or Premium. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"hub"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the ExpressRoute Circuit. |
| <a name="output_name"></a> [name](#output\_name) | The name of the ExpressRoute Circuit. |
| <a name="output_service_key"></a> [service\_key](#output\_service\_key) | The service key of the ExpressRoute Circuit. |
| <a name="output_service_provider_provisioning_state"></a> [service\_provider\_provisioning\_state](#output\_service\_provider\_provisioning\_state) | The provisioning state of the ExpressRoute Circuit with the service provider. |
<!-- END_TF_DOCS -->