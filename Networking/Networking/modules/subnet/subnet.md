# Módulo Terraform: Subnet

Despliega una `Subnet` y, opcionalmente, sus asociaciones de `NSG`, `Route Table` y `NAT Gateway`.

## Cuándo usarlo

- cuando necesitas segmentar una VNet en dominios lógicos de red
- cuando quieres aplicar políticas de salida, seguridad y enrutamiento por subnet

## Entradas relevantes

- `address_prefixes`: prefijos CIDR de la subnet
- `service_endpoints`: endpoints de servicio opcionales
- `service_endpoint_policy_ids`: políticas de service endpoint opcionales
- `private_endpoint_network_policies`: control de políticas de red para private endpoints
- `private_link_service_network_policies`: control de políticas para private link services
- `delegations`: delegaciones del servicio sobre la subnet
- `associate_nsg`, `associate_route_table`, `associate_nat_gateway`: activan asociaciones opcionales
- `nsg_id`, `route_table_id`, `nat_gateway_id`: IDs resueltos desde claves internas o recursos externos

## Restricciones y notas

- la asociación a `NAT Gateway` es por subnet
- para `Azure Bastion` debes usar una subnet dedicada llamada `AzureBastionSubnet`
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_subnet`, `azurerm_subnet_network_security_group_association`, `azurerm_subnet_route_table_association` y `azurerm_subnet_nat_gateway_association`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association
