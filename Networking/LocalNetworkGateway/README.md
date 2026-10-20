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
| [azurerm_local_network_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | (Optional) List of on-premises network CIDR ranges. | `list(string)` | `[]` | no |
| <a name="input_bgp_settings"></a> [bgp\_settings](#input\_bgp\_settings) | (Optional) BGP settings for the on-premises device.<br/><br/>Attributes:<br/>  - asn: BGP ASN.<br/>  - bgp\_peering\_address: BGP peering IP.<br/>  - peer\_weight: Peer weight. | <pre>object({<br/>    asn                 = number<br/>    bgp_peering_address = string<br/>    peer_weight         = optional(number, 0)<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Local Network Gateway. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_gateway_address"></a> [gateway\_address](#input\_gateway\_address) | (Optional) The public IP of the on-premises VPN device. Required if gateway\_fqdn not set. | `string` | `null` | no |
| <a name="input_gateway_fqdn"></a> [gateway\_fqdn](#input\_gateway\_fqdn) | (Optional) The FQDN of the on-premises VPN device. Required if gateway\_address not set. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the Local Network Gateway. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"lgw"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"onprem"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Local Network Gateway. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Local Network Gateway. |
<!-- END_TF_DOCS -->