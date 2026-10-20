# Módulo Terraform: Container App Environment Custom Domain

Configura un sufijo DNS personalizado para todo el `Container App Environment`.

## Recursos Terraform

- `azurerm_container_app_environment_custom_domain`

## Cuándo usarlo

- cuando quieres que las apps del entorno usen un sufijo DNS corporativo común
- cuando centralizas certificados y naming del entorno

## Entradas relevantes

- `container_app_environment_id`
- `dns_suffix`
- `certificate_blob_base64`
- `certificate_password`

## Restricciones y notas

- este recurso trabaja a nivel de entorno, no a nivel de app individual
- el certificado se pasa inline como bundle PFX o PEM codificado en base64
- la verificación DNS y el ruteo externo siguen dependiendo de tu zona DNS

## Outputs principales

- `id`
- `dns_suffix`

## Fuente de referencia

- Terraform Registry: `azurerm_container_app_environment_custom_domain`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_custom_domain
