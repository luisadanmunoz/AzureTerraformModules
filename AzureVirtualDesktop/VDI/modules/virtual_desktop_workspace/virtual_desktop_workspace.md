# Módulo Terraform: Virtual Desktop Workspace

Despliega un `Virtual Desktop Workspace` de Azure Virtual Desktop.

## Recursos Terraform

- `azurerm_virtual_desktop_workspace`

## Cuándo usarlo

- cuando necesitas publicar escritorios o RemoteApps a usuarios finales
- cuando quieres agrupar application groups dentro de un punto de acceso único

## Entradas relevantes

- `resource_group_name`
- `location`
- `friendly_name`
- `public_network_access_enabled`

## Dependencias habituales

- application groups asociados mediante `virtual_desktop_workspace_application_group_association`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_virtual_desktop_workspace`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_workspace
