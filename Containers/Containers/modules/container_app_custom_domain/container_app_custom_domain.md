# Módulo Terraform: Container App Custom Domain

Asocia un dominio personalizado a una `container_app`.

## Recursos Terraform

- `azurerm_container_app_custom_domain`

## Cuándo usarlo

- cuando quieres publicar una app con hostname corporativo
- cuando necesitas un certificado propio o quieres dejar que Azure emita uno gestionado

## Entradas relevantes

- `container_app_id`
- `container_app_environment_certificate_id`
- `certificate_binding_type`

## Dependencias habituales

- una `container_app` existente
- DNS de verificación configurado
- un `container_app_environment_certificate` si no usas certificado gestionado por Azure

## Restricciones y notas

- si pasas `container_app_environment_certificate_id`, debes definir `certificate_binding_type`
- para certificados gestionados por Azure, deja ambos campos de certificado a `null`
- la validación DNS y algunos cambios de certificados gestionados pueden ser asíncronos del lado del servicio

## Outputs principales

- `id`
- `name`
- `container_app_environment_managed_certificate_id`

## Fuente de referencia

- Terraform Registry: `azurerm_container_app_custom_domain`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_custom_domain
