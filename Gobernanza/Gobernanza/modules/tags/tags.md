# Módulo Terraform: Tags

Construye un **mapa de tags estándar** para reutilizarlo en otros módulos del catálogo.

## Cuándo usarlo

- cuando quieres homogeneizar tagging corporativo
- cuando necesitas componer tags de negocio y de plataforma en un único mapa

## Recurso Terraform

- no crea recursos

## SKU

- no aplica

## Tags recomendadas

- `environment`
- `owner`
- `cost_center`
- `managed_by`
- `data_classification`
- `criticality`

## Recomendaciones

- evita secretos en tags
- mantén nomenclatura estable en minúsculas
- usa este módulo como fuente común en otros stacks

## Entradas relevantes

- `workload_name`
- `environment`
- `owner`
- `cost_center`
- `data_classification`
- `criticality`
- `managed_by`
- `custom_tags`

## Restricciones y notas

- este módulo no crea recursos Azure; solo construye un mapa reutilizable
- conviene mantener claves de tags estables a nivel corporativo para facilitar reporting y policy
- SKU: no aplica
