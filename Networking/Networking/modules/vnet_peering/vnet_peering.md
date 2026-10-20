# Módulo Terraform: VNet Peering

Despliega un `VNet Peering` entre redes virtuales de Azure.

## Cuándo usarlo

- cuando quieres conectar VNets sin pasar por Internet
- cuando diseñas topologías hub-spoke o segmentación por entornos

## Entradas relevantes

- `virtual_network_name`: nombre de la VNet local
- `remote_virtual_network_id`: ID de la VNet remota
- `allow_virtual_network_access`, `allow_forwarded_traffic`, `allow_gateway_transit` y `use_remote_gateways`: flags del peering

## Restricciones y notas

- el peering no es automáticamente bidireccional; normalmente debes crear el peering en ambos sentidos
- `use_remote_gateways` y `allow_gateway_transit` requieren diseño cuidadoso y no son válidos en cualquier combinación
- revisa solapes de direccionamiento antes de establecer peerings
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_virtual_network_peering`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering
