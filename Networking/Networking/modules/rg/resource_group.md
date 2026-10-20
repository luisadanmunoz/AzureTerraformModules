# Módulo Terraform: Resource Group

Despliega un `Resource Group` para recursos de networking.

## Cuándo usarlo

- como contenedor lógico y administrativo para agrupar recursos de red
- cuando quieres aplicar RBAC, tags, locks o lifecycle sobre un conjunto coherente de recursos

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
