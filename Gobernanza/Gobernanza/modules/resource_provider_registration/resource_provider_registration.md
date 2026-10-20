# Módulo Terraform: Resource Provider Registration

Registra un **Resource Provider** de Azure en la suscripción objetivo.

## Recurso Terraform

- `azurerm_resource_provider_registration`

## SKU

- no aplica

## Cuándo usarlo

- cuando un servicio de Azure no está registrado todavía en la suscripción
- cuando quieres controlar explícitamente el registro desde Terraform

## Recomendaciones

- no registres providers innecesarios
- mantén el nombre con prefijo `Microsoft.`

## Entradas relevantes

- `resource_provider_name`

## Restricciones y notas

- el registro puede tardar en completarse según el provider
- no todos los servicios requieren que lo gestiones explícitamente desde Terraform, pero en entornos controlados puede ser útil
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_resource_provider_registration`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_provider_registration
