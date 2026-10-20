# Módulo Terraform: Public IP

Despliega una `Public IP` de Azure.

## Cuándo usarlo

- cuando necesitas exponer un frontend público para `Load Balancer`, `Bastion`, `Application Gateway`, `VPN Gateway` u otros recursos
- cuando quieres reservar una IP estática o dinámica según el caso

## Entradas relevantes

- `allocation_method`: `Static` o `Dynamic`
- `sku`: normalmente `Basic` o `Standard`
- `sku_tier`: `Regional` o `Global` según el caso soportado
- `domain_name_label`: etiqueta DNS opcional
- `reverse_fqdn`: PTR inverso opcional
- `ip_version`: `IPv4` o `IPv6`
- `idle_timeout_in_minutes`: timeout de inactividad
- `zones`: zonas de disponibilidad

## Restricciones y notas

- para recursos corporativos actuales suele preferirse `Standard`
- revisa compatibilidad entre `sku`, `allocation_method` y el recurso consumidor
- no todos los escenarios soportan `Global` o `zones`
- SKU: `Basic` y `Standard`

## Fuente de referencia

- Terraform Registry: `azurerm_public_ip`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
