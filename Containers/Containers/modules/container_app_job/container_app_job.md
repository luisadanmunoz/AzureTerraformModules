# Módulo Terraform: Container App Job

Despliega un `Container App Job` para procesos batch, manuales, programados o disparados por eventos.

## Recursos Terraform

- `azurerm_container_app_job`

## Cuándo usarlo

- cuando quieres ejecutar tareas puntuales o recurrentes sin mantener una app siempre activa
- cuando necesitas un patrón de ejecución distinto al de `container_app`

## Entradas relevantes

- `container_app_environment_id`
- `resource_group_name`
- `replica_timeout_in_seconds`
- `manual_trigger_config`
- `event_trigger_config`
- `schedule_trigger_config`
- `template`
- `secret`
- `registry`

## Restricciones y notas

- debes definir exactamente un trigger: `manual_trigger_config`, `event_trigger_config` o `schedule_trigger_config`
- `template.container` debe incluir al menos un contenedor
- cada bloque `registry` debe usar o bien `identity` o bien `username` y `password_secret_name`
- si un secreto usa `identity`, también debe llevar `key_vault_secret_id`

## Outputs principales

- `id`
- `name`
- `event_stream_endpoint`

## Fuente de referencia

- Terraform Registry: `azurerm_container_app_job`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_job
