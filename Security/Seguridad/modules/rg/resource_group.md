# Módulo Terraform: Resource Group

Despliega un `Resource Group` para recursos de seguridad.

## Cuándo usarlo

- como contenedor lógico y administrativo para agrupar controles y servicios de seguridad
- cuando quieres aplicar RBAC, tags, locks o lifecycle sobre un dominio coherente de seguridad

## Entradas relevantes

- `resource_group_name`: nombre del grupo de recursos
- `location`: región principal de referencia
- `tags`: etiquetas del recurso

## Restricciones y notas

- el `Resource Group` no tiene SKU
- la `location` del grupo no obliga a que todos los recursos internos estén en esa región, pero conviene mantener coherencia operativa
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_resource_group`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
