# Módulo Terraform: NAT Gateway

Despliega un `NAT Gateway` y asocia `Public IPs` para salida a Internet de subnets privadas.

## Cuándo usarlo

- cuando quieres salida a Internet controlada sin exponer recursos con IP pública individual
- cuando necesitas una estrategia de egress compartida para varias cargas

## Entradas relevantes

- `sku_name`: en este recurso el SKU habitual y soportado es `Standard`
- `idle_timeout_in_minutes`: timeout de conexiones salientes
- `public_ip_id_map`: mapa de `Public IPs` a asociar al NAT Gateway
- `public_ip_prefix_id_map`: mapa de `Public IP Prefixes` a asociar al NAT Gateway

## Restricciones y notas

- el NAT Gateway no se aplica por sí solo a la VNet; debe asociarse después a una subnet
- las `Public IPs` asociadas deben ser compatibles con el recurso y estar en la misma región
- los `Public IP Prefixes` también se soportan en el provider y este módulo ya los admite por ID
- SKU: `Standard`

## Fuente de referencia

- Terraform Registry: `azurerm_nat_gateway`, `azurerm_nat_gateway_public_ip_association` y `azurerm_nat_gateway_public_ip_prefix_association`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_prefix_association
