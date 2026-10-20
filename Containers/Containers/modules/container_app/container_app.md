# Módulo Terraform: Container App

Despliega una `Container App` de Azure con soporte para revisiones, ingress, secretos, Dapr, escalado y volúmenes.

## Recursos Terraform

- `azurerm_container_app`

## Cuándo usarlo

- cuando quieres publicar una app HTTP o TCP en Azure Container Apps
- cuando necesitas escalado con KEDA, secretos, Dapr o rutas por revisión

## Entradas relevantes

- `container_app_environment_id`
- `resource_group_name`
- `revision_mode`
- `ingress`
- `secret`
- `registry`
- `template`
- `dapr`

## Dependencias habituales

- un `container_app_environment` existente
- `container_app_environment_storage` si vas a montar `AzureFile` o `NfsAzureFile`
- un registry accesible si usas imágenes privadas

## Restricciones y notas

- `template.container` debe incluir al menos un contenedor
- si configuras `ingress`, los porcentajes de `traffic_weight` deben sumar `100`
- si `ingress.transport = "tcp"`, debes indicar `exposed_port`
- cada bloque `registry` debe usar o bien `identity` o bien `username` y `password_secret_name`
- si un secreto usa `identity`, también debe llevar `key_vault_secret_id`

## Outputs principales

- `id`
- `name`
- `latest_revision_name`
- `latest_revision_fqdn`
- `custom_domain_verification_id`

## Fuente de referencia

- Terraform Registry: `azurerm_container_app`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app
