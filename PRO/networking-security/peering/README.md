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