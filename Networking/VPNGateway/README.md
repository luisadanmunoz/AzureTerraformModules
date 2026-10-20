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
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_network_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_active_active"></a> [active\_active](#input\_active\_active) | (Optional) Enable active-active mode. Requires two IP configurations. | `bool` | `false` | no |
| <a name="input_bgp_settings"></a> [bgp\_settings](#input\_bgp\_settings) | (Optional) BGP settings configuration.<br/><br/>Attributes:<br/>  - asn: Autonomous System Number.<br/>  - peering\_addresses: List of peering address configurations. | <pre>object({<br/>    asn = optional(number, 65515)<br/>    peering_addresses = optional(list(object({<br/>      ip_configuration_name = string<br/>      apipa_addresses       = optional(list(string), null)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the VPN Gateway. | `bool` | `true` | no |
| <a name="input_custom_route"></a> [custom\_route](#input\_custom\_route) | (Optional) Custom routes for the gateway.<br/><br/>Attributes:<br/>  - address\_prefixes: List of address prefixes. | <pre>object({<br/>    address_prefixes = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration. | <pre>object({<br/>    name                       = optional(string, "diag-vpngw")<br/>    log_analytics_workspace_id = optional(string, null)<br/>    storage_account_id         = optional(string, null)<br/>    log_categories = optional(list(string), [<br/>      "GatewayDiagnosticLog",<br/>      "TunnelDiagnosticLog",<br/>      "RouteDiagnosticLog",<br/>      "IKEDiagnosticLog",<br/>      "P2SDiagnosticLog"<br/>    ])<br/>    metric_categories = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_dns_forwarding_enabled"></a> [dns\_forwarding\_enabled](#input\_dns\_forwarding\_enabled) | (Optional) Enable DNS forwarding. | `bool` | `false` | no |
| <a name="input_enable_bgp"></a> [enable\_bgp](#input\_enable\_bgp) | (Optional) Enable BGP for the gateway. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_generation"></a> [generation](#input\_generation) | (Optional) VPN Gateway generation: Generation1 or Generation2. | `string` | `"Generation2"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the VPN Gateway. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"vpngw"` | no |
| <a name="input_private_ip_address_enabled"></a> [private\_ip\_address\_enabled](#input\_private\_ip\_address\_enabled) | (Optional) Enable private IP address on the gateway. | `bool` | `false` | no |
| <a name="input_public_ip_id"></a> [public\_ip\_id](#input\_public\_ip\_id) | (Optional) Existing Public IP ID. If not provided, a new one will be created.<br/>DEPENDENCY: Must be Standard SKU for AZ SKUs, Basic for non-AZ. | `string` | `null` | no |
| <a name="input_public_ip_id_secondary"></a> [public\_ip\_id\_secondary](#input\_public\_ip\_id\_secondary) | (Optional) Secondary Public IP ID for active-active mode. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) Gateway SKU.<br/>VPN: Basic, VpnGw1, VpnGw2, VpnGw3, VpnGw4, VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ, VpnGw4AZ, VpnGw5AZ<br/>ExpressRoute: Standard, HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ | `string` | `"VpnGw1AZ"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The ID of the GatewaySubnet.<br/>DEPENDENCY: Subnet named "GatewaySubnet" must exist with minimum /27 prefix. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Optional) Gateway type: Vpn or ExpressRoute. | `string` | `"Vpn"` | no |
| <a name="input_vpn_client_configuration"></a> [vpn\_client\_configuration](#input\_vpn\_client\_configuration) | (Optional) Point-to-Site VPN client configuration.<br/><br/>Attributes:<br/>  - address\_space: Client address pool CIDR.<br/>  - vpn\_client\_protocols: IkeV2, SSTP, OpenVPN.<br/>  - vpn\_auth\_types: AAD, Certificate, Radius.<br/>  - root\_certificates: List of root certificates.<br/>  - revoked\_certificates: List of revoked certificates.<br/>  - aad\_tenant: Azure AD tenant URL.<br/>  - aad\_audience: Azure AD audience.<br/>  - aad\_issuer: Azure AD issuer.<br/>  - radius\_server\_address: RADIUS server IP.<br/>  - radius\_server\_secret: RADIUS shared secret. | <pre>object({<br/>    address_space        = list(string)<br/>    vpn_client_protocols = optional(list(string), ["IkeV2", "OpenVPN"])<br/>    vpn_auth_types       = optional(list(string), ["Certificate"])<br/>    root_certificates = optional(list(object({<br/>      name             = string<br/>      public_cert_data = string<br/>    })), [])<br/>    revoked_certificates = optional(list(object({<br/>      name       = string<br/>      thumbprint = string<br/>    })), [])<br/>    aad_tenant              = optional(string, null)<br/>    aad_audience            = optional(string, null)<br/>    aad_issuer              = optional(string, null)<br/>    radius_server_address   = optional(string, null)<br/>    radius_server_secret    = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_vpn_type"></a> [vpn\_type](#input\_vpn\_type) | (Optional) VPN type: RouteBased or PolicyBased. | `string` | `"RouteBased"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"hub"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bgp_asn"></a> [bgp\_asn](#output\_bgp\_asn) | BGP ASN. |
| <a name="output_bgp_peering_address"></a> [bgp\_peering\_address](#output\_bgp\_peering\_address) | BGP peering address. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VPN Gateway. |
| <a name="output_name"></a> [name](#output\_name) | The name of the VPN Gateway. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The primary public IP address. |
| <a name="output_public_ip_address_secondary"></a> [public\_ip\_address\_secondary](#output\_public\_ip\_address\_secondary) | The secondary public IP address (active-active). |
<!-- END_TF_DOCS -->