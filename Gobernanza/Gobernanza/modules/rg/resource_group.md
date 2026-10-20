# Módulo Terraform: Resource Group

Despliega un **Azure Resource Group**, que es la unidad lógica básica para agrupar recursos de una solución.

## Cuándo usarlo

- para agrupar recursos por aplicación, entorno o dominio
- para aplicar RBAC, locks, budgets y tags a un conjunto coherente de recursos

## Recurso Terraform

- `azurerm_resource_group`

## SKU

- no aplica

## Inputs principales

- `resource_group_name`: nombre del RG
- `location`: región Azure
- `tags`: etiquetas de gobierno

## Restricciones relevantes

- el nombre no puede estar vacío
- el límite habitual del nombre es 90 caracteres
- la región debe ser una región válida de Azure

## Recomendaciones

- usa naming consistente por dominio y entorno
- no mezcles recursos no relacionados dentro del mismo RG
- aplica tags mínimas de entorno, propietario y coste

## Fuente de referencia

- Terraform Registry: `azurerm_resource_group`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
