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
| [azurerm_virtual_network_peering.reverse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allow_forwarded_traffic"></a> [allow\_forwarded\_traffic](#input\_allow\_forwarded\_traffic) | (Optional) Allow forwarded traffic from VMs in the remote VNet.<br/>Required for hub-spoke topologies with NVA.<br/>Default is false. | `bool` | `false` | no |
| <a name="input_allow_gateway_transit"></a> [allow\_gateway\_transit](#input\_allow\_gateway\_transit) | (Optional) Allow the remote VNet to use this VNet's gateway.<br/>Enable on hub VNet that has the VPN/ExpressRoute Gateway.<br/>DEPENDENCY: VNet Gateway must exist in this VNet.<br/>Default is false. | `bool` | `false` | no |
| <a name="input_allow_virtual_network_access"></a> [allow\_virtual\_network\_access](#input\_allow\_virtual\_network\_access) | (Optional) Allow VMs in the remote VNet to access VMs in the local VNet.<br/>Default is true. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the VNet Peering. | `bool` | `true` | no |
| <a name="input_create_reverse_peering"></a> [create\_reverse\_peering](#input\_create\_reverse\_peering) | (Optional) Create the reverse peering (from remote to local VNet).<br/>Requires appropriate permissions on the remote subscription.<br/>Default is false. | `bool` | `false` | no |
| <a name="input_local_subnet_names"></a> [local\_subnet\_names](#input\_local\_subnet\_names) | (Optional) Only peer specific subnets from the local VNet.<br/>If null, all subnets are peered. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the VNet peering.<br/>If not provided, auto-generated as: peer-{source\_vnet}-to-{remote\_vnet} | `string` | `null` | no |
| <a name="input_remote_subnet_names"></a> [remote\_subnet\_names](#input\_remote\_subnet\_names) | (Optional) Only peer specific subnets from the remote VNet.<br/>If null, all subnets are peered. | `list(string)` | `null` | no |
| <a name="input_remote_virtual_network_id"></a> [remote\_virtual\_network\_id](#input\_remote\_virtual\_network\_id) | (Required) The full resource ID of the remote Virtual Network to peer with.<br/>DEPENDENCY: Remote Virtual Network must exist.<br/>Format: /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Network/virtualNetworks/{vnet} | `string` | n/a | yes |
| <a name="input_remote_virtual_network_name"></a> [remote\_virtual\_network\_name](#input\_remote\_virtual\_network\_name) | (Optional) The name of the remote VNet (used for auto-naming if 'name' not provided). | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group containing the source Virtual Network.<br/>DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_reverse_allow_forwarded_traffic"></a> [reverse\_allow\_forwarded\_traffic](#input\_reverse\_allow\_forwarded\_traffic) | (Optional) allow\_forwarded\_traffic for reverse peering. | `bool` | `false` | no |
| <a name="input_reverse_allow_gateway_transit"></a> [reverse\_allow\_gateway\_transit](#input\_reverse\_allow\_gateway\_transit) | (Optional) allow\_gateway\_transit for reverse peering. | `bool` | `false` | no |
| <a name="input_reverse_allow_virtual_network_access"></a> [reverse\_allow\_virtual\_network\_access](#input\_reverse\_allow\_virtual\_network\_access) | (Optional) allow\_virtual\_network\_access for reverse peering. | `bool` | `true` | no |
| <a name="input_reverse_peering_name"></a> [reverse\_peering\_name](#input\_reverse\_peering\_name) | (Optional) Name for the reverse peering. Auto-generated if not provided. | `string` | `null` | no |
| <a name="input_reverse_peering_resource_group_name"></a> [reverse\_peering\_resource\_group\_name](#input\_reverse\_peering\_resource\_group\_name) | (Optional) Resource Group name of the remote VNet (for reverse peering).<br/>Required if create\_reverse\_peering is true. | `string` | `null` | no |
| <a name="input_reverse_use_remote_gateways"></a> [reverse\_use\_remote\_gateways](#input\_reverse\_use\_remote\_gateways) | (Optional) use\_remote\_gateways for reverse peering. | `bool` | `false` | no |
| <a name="input_use_remote_gateways"></a> [use\_remote\_gateways](#input\_use\_remote\_gateways) | (Optional) Use the remote VNet's gateway for transit.<br/>Enable on spoke VNets to use hub's gateway.<br/>DEPENDENCY: Remote VNet must have gateway\_transit enabled and a gateway deployed.<br/>Cannot be true if this VNet has a gateway.<br/>Default is false. | `bool` | `false` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | (Required) The name of the source Virtual Network.<br/>DEPENDENCY: Virtual Network must exist. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VNet Peering. |
| <a name="output_name"></a> [name](#output\_name) | The name of the VNet Peering. |
| <a name="output_remote_virtual_network_id"></a> [remote\_virtual\_network\_id](#output\_remote\_virtual\_network\_id) | The ID of the remote Virtual Network. |
| <a name="output_reverse_peering_id"></a> [reverse\_peering\_id](#output\_reverse\_peering\_id) | The ID of the reverse VNet Peering (if created). |
| <a name="output_reverse_peering_name"></a> [reverse\_peering\_name](#output\_reverse\_peering\_name) | The name of the reverse VNet Peering (if created). |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The name of the local Virtual Network. |
<!-- END_TF_DOCS -->