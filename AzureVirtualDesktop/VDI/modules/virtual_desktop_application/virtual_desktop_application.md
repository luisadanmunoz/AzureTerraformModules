# Módulo Terraform: Virtual Desktop Application

Publica una `Virtual Desktop Application` dentro de un application group de tipo `RemoteApp`.

## Recursos Terraform

- `azurerm_virtual_desktop_application`

## Cuándo usarlo

- cuando quieres publicar aplicaciones individuales en AVD
- cuando necesitas controlar icono, argumentos y visibilidad en portal

## Entradas relevantes

- `application_group_id`
- `path`
- `command_line_argument_policy`
- `icon_path`

## Restricciones y notas

- este recurso se usa normalmente con `application_group` de tipo `RemoteApp`
- `command_line_argument_policy` solo acepta `DoNotAllow`, `Allow` o `Require`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_virtual_desktop_application`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application
