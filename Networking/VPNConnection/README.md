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
| [azurerm_virtual_network_gateway_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_connection_protocol"></a> [connection\_protocol](#input\_connection\_protocol) | (Optional) The IKE protocol version: IKEv1 or IKEv2. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the VPN Connection. | `bool` | `true` | no |
| <a name="input_dpd_timeout_seconds"></a> [dpd\_timeout\_seconds](#input\_dpd\_timeout\_seconds) | (Optional) Dead Peer Detection timeout in seconds. | `number` | `null` | no |
| <a name="input_enable_bgp"></a> [enable\_bgp](#input\_enable\_bgp) | (Optional) Enable BGP for the connection. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_express_route_circuit_id"></a> [express\_route\_circuit\_id](#input\_express\_route\_circuit\_id) | (Optional) The ID of the ExpressRoute Circuit for ExpressRoute connections.<br/>DEPENDENCY: ExpressRoute Circuit must exist.<br/>Required when type is ExpressRoute. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_ipsec_policy"></a> [ipsec\_policy](#input\_ipsec\_policy) | (Optional) IPsec policy configuration for the connection.<br/><br/>Attributes:<br/>  - dh\_group:           DH Group: DHGroup1, DHGroup2, DHGroup14, DHGroup24, DHGroup2048, ECP256, ECP384, None.<br/>  - ike\_encryption:     IKE encryption: AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES256.<br/>  - ike\_integrity:      IKE integrity: GCMAES128, GCMAES256, MD5, SHA1, SHA256, SHA384.<br/>  - ipsec\_encryption:   IPsec encryption: AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES192, GCMAES256, None.<br/>  - ipsec\_integrity:    IPsec integrity: GCMAES128, GCMAES192, GCMAES256, MD5, SHA1, SHA256.<br/>  - pfs\_group:          PFS Group: ECP256, ECP384, None, PFS1, PFS2, PFS14, PFS24, PFS2048, PFSMM.<br/>  - sa\_lifetime:        SA lifetime in seconds.<br/>  - sa\_datasize:        SA data size in KB. | <pre>object({<br/>    dh_group         = string<br/>    ike_encryption   = string<br/>    ike_integrity    = string<br/>    ipsec_encryption = string<br/>    ipsec_integrity  = string<br/>    pfs_group        = string<br/>    sa_lifetime      = optional(number, 27000)<br/>    sa_datasize      = optional(number, 102400000)<br/>  })</pre> | `null` | no |
| <a name="input_local_network_gateway_id"></a> [local\_network\_gateway\_id](#input\_local\_network\_gateway\_id) | (Optional) The ID of the Local Network Gateway for IPsec connections.<br/>DEPENDENCY: Local Network Gateway must exist.<br/>Required when type is IPsec. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the VPN Connection. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"vcn"` | no |
| <a name="input_peer_virtual_network_gateway_id"></a> [peer\_virtual\_network\_gateway\_id](#input\_peer\_virtual\_network\_gateway\_id) | (Optional) The ID of the peer Virtual Network Gateway for Vnet2Vnet connections.<br/>Required when type is Vnet2Vnet. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_shared_key"></a> [shared\_key](#input\_shared\_key) | (Optional) The shared IPSec key. Required for IPsec and Vnet2Vnet connections. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_traffic_selector_policy"></a> [traffic\_selector\_policy](#input\_traffic\_selector\_policy) | (Optional) List of traffic selector policies for the connection.<br/><br/>Attributes:<br/>  - local\_address\_cidrs:  List of local address CIDRs.<br/>  - remote\_address\_cidrs: List of remote address CIDRs. | <pre>list(object({<br/>    local_address_cidrs  = list(string)<br/>    remote_address_cidrs = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of connection: IPsec, Vnet2Vnet, or ExpressRoute. | `string` | n/a | yes |
| <a name="input_use_policy_based_traffic_selectors"></a> [use\_policy\_based\_traffic\_selectors](#input\_use\_policy\_based\_traffic\_selectors) | (Optional) Enable policy-based traffic selectors. | `bool` | `false` | no |
| <a name="input_virtual_network_gateway_id"></a> [virtual\_network\_gateway\_id](#input\_virtual\_network\_gateway\_id) | (Required) The ID of the Virtual Network Gateway.<br/>DEPENDENCY: Virtual Network Gateway must exist. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"hub"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VPN Connection. |
| <a name="output_name"></a> [name](#output\_name) | The name of the VPN Connection. |
<!-- END_TF_DOCS -->