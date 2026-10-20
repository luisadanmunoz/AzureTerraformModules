# Módulo Terraform: Virtual Desktop Host Pool Registration Info

Genera el `registration token` de un host pool de Azure Virtual Desktop.

## Recursos Terraform

- `azurerm_virtual_desktop_host_pool_registration_info`

## Cuándo usarlo

- cuando necesitas registrar nuevos session hosts en un host pool
- cuando quieres separar la vida del token del resto del host pool

## Entradas relevantes

- `hostpool_id`
- `expiration_date`

## Restricciones y notas

- solo deberia existir un registro de `registration_info` por host pool
- el token exportado es sensible

## Outputs principales

- `id`
- `token`

## Fuente de referencia

- Terraform Registry: `azurerm_virtual_desktop_host_pool_registration_info`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool_registration_info
