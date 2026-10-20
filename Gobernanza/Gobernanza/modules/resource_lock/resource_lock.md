# Módulo Terraform: Resource Lock

Despliega un **Azure Management Lock** para proteger recursos ante borrados o modificaciones accidentales.

## Recurso Terraform

- `azurerm_management_lock`

## SKU

- no aplica

## Lock levels soportados

- `CanNotDelete`
- `ReadOnly`

## Entradas relevantes

- `lock_name`
- `scope`
- `lock_level`
- `notes`

## Recomendaciones y notas

- usa `CanNotDelete` como opción por defecto
- usa `ReadOnly` solo si entiendes el impacto operativo
- no aplica sobre management groups

## Fuente de referencia

- Terraform Registry: `azurerm_management_lock`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock
