# Módulo Terraform: Load Balancer

Despliega un `Azure Load Balancer` con frontends, backend pools, probes y reglas opcionales.

## Cuándo usarlo

- para balanceo L4 interno o público
- para exponer aplicaciones con alta disponibilidad
- como pieza base de arquitecturas hub-spoke o servicios IaaS

## Entradas relevantes

- `sku`: el provider admite `Basic`, `Standard` y `Gateway`
- `frontend_ip_configurations`: define los frontends públicos o privados
- `backend_address_pools`: pools lógicos para asociar NICs o direcciones backend
- `probes`: health probes del balanceador
- `rules`: reglas de publicación entre frontend y backend

## Restricciones y notas

- revisa compatibilidad entre `sku`, zonas y tipo de frontend
- para producción suele preferirse `Standard`
- si el frontend es interno debes aportar `subnet_id` o IP privada según diseño
- si el frontend es público debes asociar una `Public IP`
- `sku_tier` en el provider se maneja como `Regional` o `Global`
- SKU: `Basic`, `Standard` y `Gateway`, recomendando `Standard` salvo necesidad específica

## Fuente de referencia

- Terraform Registry: `azurerm_lb`, `azurerm_lb_backend_address_pool`, `azurerm_lb_probe` y `azurerm_lb_rule`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule
