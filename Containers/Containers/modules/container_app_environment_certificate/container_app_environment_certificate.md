# Módulo Terraform: Container App Environment Certificate

Gestiona certificados reutilizables dentro del `Container App Environment`, ya sea desde un PFX/PEM o desde Key Vault.

## Recursos Terraform

- `azurerm_container_app_environment_certificate`

## Cuándo usarlo

- cuando quieres asociar certificados TLS a dominios del entorno o de apps
- cuando quieres desacoplar la gestión del certificado del ciclo de vida de la app

## Entradas relevantes

- `container_app_environment_id`
- `certificate_blob_base64`
- `certificate_password`
- `certificate_key_vault`

## Dependencias habituales

- `certificate_key_vault.key_vault_secret_id` si el certificado vive en Key Vault
- una identidad con permisos adecuados sobre Key Vault si usas referencia externa

## Restricciones y notas

- debes elegir exactamente una fuente: `certificate_blob_base64` o `certificate_key_vault`
- si usas `certificate_blob_base64`, `certificate_password` es obligatoria
- si usas Key Vault, revisa permisos del secreto o certificado para la identidad seleccionada

## Outputs principales

- `id`
- `name`
- `thumbprint`
- `subject_name`

## Fuente de referencia

- Terraform Registry: `azurerm_container_app_environment_certificate`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_certificate
