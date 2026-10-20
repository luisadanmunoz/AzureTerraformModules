# Módulo Terraform: Route Table

Despliega una `Route Table` de Azure con rutas inline opcionales.

## Cuándo usarlo

- cuando necesitas UDRs para controlar el siguiente salto del tráfico
- cuando quieres encaminar tráfico a `Firewall`, appliances virtuales o Internet según el diseño

## Entradas relevantes

- `route_table_name`: nombre de la tabla
- `bgp_route_propagation_enabled`: controla propagación de rutas BGP en la tabla
- `routes`: lista de rutas con `address_prefix`, `next_hop_type` y, cuando aplica, `next_hop_in_ip_address`

## Restricciones y notas

- las rutas se definen inline en el propio recurso
- si `next_hop_type` requiere IP, debes informar `next_hop_in_ip_address`
- la asociación a subnets se hace desde el módulo `subnet`, no desde este módulo
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_route_table`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table
