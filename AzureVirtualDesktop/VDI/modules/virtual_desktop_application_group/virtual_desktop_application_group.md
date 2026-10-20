# Módulo Terraform: Virtual Desktop Application Group

Despliega un `Virtual Desktop Application Group` para escritorios o RemoteApps.

## Recursos Terraform

- `azurerm_virtual_desktop_application_group`

## Cuándo usarlo

- cuando necesitas publicar un escritorio completo
- cuando quieres agrupar RemoteApps bajo un host pool

## Entradas relevantes

- `type`
- `host_pool_id`
- `default_desktop_display_name`

## Restricciones y notas

- `type` solo acepta `RemoteApp` o `Desktop`
- `default_desktop_display_name` es especialmente relevante para grupos `Desktop`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_virtual_desktop_application_group`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application_group
