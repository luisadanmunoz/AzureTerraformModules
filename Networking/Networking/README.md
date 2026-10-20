# Networking Azure con Terraform

Catálogo base de networking para Azure siguiendo la misma estructura que `Gobernanza`.

## Módulos incluidos

- `rg`
- `vnet`
- `subnet`
- `nsg`
- `route_table`
- `public_ip`
- `nat_gateway`
- `private_dns_zone`
- `private_dns_zone_virtual_network_link`
- `private_endpoint`
- `vnet_peering`
- `network_watcher`
- `bastion_host`
- `load_balancer`

## Estrategia de uso

- usa `*_name` cuando el recurso nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- arranca por `rg`, `vnet`, `nsg`, `route_table` y `subnet`
- añade `nat_gateway`, `private_dns_zone`, `private_dns_zone_virtual_network_link`, `private_endpoint` y `vnet_peering` después
- usa `bastion_host` sobre una subnet dedicada `AzureBastionSubnet`
- usa `load_balancer` con `Standard SKU` como opción preferente en entornos corporativos
- crea `network_watcher` por región cuando quieras habilitar observabilidad de red
