# Módulo Terraform: Virtual Network

Despliega una `Virtual Network` de Azure.

## Cuándo usarlo

- como base de conectividad privada en Azure
- cuando necesitas definir espacio de direcciones, DNS custom o topologías hub-spoke

## Entradas relevantes

- `virtual_network_name`: nombre de la VNet
- `address_space`: lista de prefijos CIDR de la red
- `dns_servers`: servidores DNS personalizados opcionales

## Restricciones y notas

- este módulo crea solo la VNet; las subnets se gestionan en un módulo separado
- conviene evitar solapes CIDR si vas a usar peering, VPN o ExpressRoute
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_virtual_network`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
