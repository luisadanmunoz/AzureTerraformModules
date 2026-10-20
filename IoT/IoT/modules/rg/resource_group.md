# Módulo Terraform: Resource Group

Despliega un `Resource Group` reutilizable para el catálogo de IoT.

## Recursos Terraform

- `azurerm_resource_group`

## Cuándo usarlo

- cuando quieres arrancar el stack de `IoT` desde cero
- cuando quieres separar por dominio los recursos de IoT y Digital Twins

## Entradas relevantes

- `resource_group_name`
- `location`
- `tags`

## Outputs principales

- `id`
- `name`
- `location`

## Fuente de referencia

- Terraform Registry: `azurerm_resource_group`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
