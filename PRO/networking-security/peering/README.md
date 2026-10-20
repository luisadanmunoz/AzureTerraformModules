# Terraform Module: Virtual Network Peering

Este módulo de Terraform configura el peering entre redes virtuales (VNet) en Azure, estableciendo conectividad entre una red `Hub` y una red `Spoke`.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_virtual_network_peering.peering_01`: Configura el peering desde la VNet Spoke hacia la VNet Hub.
- `azurerm_virtual_network_peering.peering_02`: Configura el peering desde la VNet Hub hacia la VNet Spoke.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                          | Tipo        | Descripción                                             | Por defecto |
|---------------------------------|------------|---------------------------------------------------------|------------|
| `peering_name_vnet_01`          | `string`   | Nombre del peering desde la VNet Spoke hacia la Hub.    | -          |
| `resource_group_vnet_01`        | `string`   | Nombre del grupo de recursos de la VNet Spoke.         | -          |
| `name_vnet_01`                  | `string`   | Nombre de la VNet Spoke.                               | -          |
| `vnet_id_01`                    | `string`   | ID de la VNet Spoke.                                   | -          |
| `use_remote_gateways_01`        | `bool`     | Permite el uso de gateways remotos en la VNet Spoke.   | -          |
| `allow_virtual_network_access_01` | `bool`    | Habilita el acceso entre redes virtuales en la Spoke.  | -          |
| `allow_forwarded_traffic_01`    | `bool`     | Habilita el tráfico reenviado en la Spoke.            | -          |
| `allow_gateway_transit_01`      | `bool`     | Habilita el tránsito de gateway en la Spoke.          | -          |
| `peering_name_vnet_02`          | `string`   | Nombre del peering desde la VNet Hub hacia la Spoke.   | -          |
| `resource_group_vnet_02`        | `string`   | Nombre del grupo de recursos de la VNet Hub.          | -          |
| `name_vnet_02`                  | `string`   | Nombre de la VNet Hub.                                | -          |
| `use_remote_gateways_02`        | `bool`     | Permite el uso de gateways remotos en la VNet Hub.    | -          |
| `allow_virtual_network_access_02` | `bool`    | Habilita el acceso entre redes virtuales en la Hub.   | -          |
| `allow_forwarded_traffic_02`    | `bool`     | Habilita el tráfico reenviado en la Hub.             | -          |
| `allow_gateway_transit_02`      | `bool`     | Habilita el tránsito de gateway en la Hub.           | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "vnet_peering" {
  source                        = "./ruta/al/modulo"
  peering_name_vnet_01          = "spoke-to-hub"
  resource_group_vnet_01        = "mi-grupo-spoke"
  name_vnet_01                  = "vnet-spoke"
  vnet_id_01                    = "spoke-vnet-id"
  use_remote_gateways_01        = false
  allow_virtual_network_access_01 = true
  allow_forwarded_traffic_01    = true
  allow_gateway_transit_01      = false
  peering_name_vnet_02          = "hub-to-spoke"
  resource_group_vnet_02        = "mi-grupo-hub"
  name_vnet_02                  = "vnet-hub"
  use_remote_gateways_02        = true
  allow_virtual_network_access_02 = true
  allow_forwarded_traffic_02    = true
  allow_gateway_transit_02      = true
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de peering entre redes virtuales en Azure.
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_azurerm.hub"></a> [azurerm.hub](#provider\_azurerm.hub) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_virtual_network_peering.peering_01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peering_02](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network.vnet_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allow_forwarded_traffic_01"></a> [allow\_forwarded\_traffic\_01](#input\_allow\_forwarded\_traffic\_01) | n/a | `bool` | n/a | yes |
| <a name="input_allow_forwarded_traffic_02"></a> [allow\_forwarded\_traffic\_02](#input\_allow\_forwarded\_traffic\_02) | n/a | `bool` | n/a | yes |
| <a name="input_allow_gateway_transit_01"></a> [allow\_gateway\_transit\_01](#input\_allow\_gateway\_transit\_01) | n/a | `bool` | n/a | yes |
| <a name="input_allow_gateway_transit_02"></a> [allow\_gateway\_transit\_02](#input\_allow\_gateway\_transit\_02) | n/a | `bool` | n/a | yes |
| <a name="input_allow_virtual_network_access_01"></a> [allow\_virtual\_network\_access\_01](#input\_allow\_virtual\_network\_access\_01) | n/a | `bool` | n/a | yes |
| <a name="input_allow_virtual_network_access_02"></a> [allow\_virtual\_network\_access\_02](#input\_allow\_virtual\_network\_access\_02) | n/a | `bool` | n/a | yes |
| <a name="input_name_vnet_01"></a> [name\_vnet\_01](#input\_name\_vnet\_01) | n/a | `string` | n/a | yes |
| <a name="input_name_vnet_02"></a> [name\_vnet\_02](#input\_name\_vnet\_02) | ############################################################################# # VIRTUAL NETWORK SUBSCRIPTION HUB - REMOTA ############################################################################# | `string` | n/a | yes |
| <a name="input_peering_name_vnet_01"></a> [peering\_name\_vnet\_01](#input\_peering\_name\_vnet\_01) | ############################################################################# # PEERING FROM - SPOKE TO HUB ############################################################################# | `string` | n/a | yes |
| <a name="input_peering_name_vnet_02"></a> [peering\_name\_vnet\_02](#input\_peering\_name\_vnet\_02) | ############################################################################# # PEERING - HUB TO SPOKE ############################################################################# | `string` | n/a | yes |
| <a name="input_resource_group_vnet_01"></a> [resource\_group\_vnet\_01](#input\_resource\_group\_vnet\_01) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_vnet_02"></a> [resource\_group\_vnet\_02](#input\_resource\_group\_vnet\_02) | n/a | `string` | n/a | yes |
| <a name="input_use_remote_gateways_01"></a> [use\_remote\_gateways\_01](#input\_use\_remote\_gateways\_01) | n/a | `bool` | n/a | yes |
| <a name="input_use_remote_gateways_02"></a> [use\_remote\_gateways\_02](#input\_use\_remote\_gateways\_02) | n/a | `bool` | n/a | yes |
| <a name="input_vnet_id_01"></a> [vnet\_id\_01](#input\_vnet\_id\_01) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->