# Módulo Terraform: Container App Environment Storage

Conecta un storage externo al `Container App Environment` para que las apps y jobs puedan montar volúmenes compartidos.

## Recursos Terraform

- `azurerm_container_app_environment_storage`

## Cuándo usarlo

- cuando quieres montar `AzureFile` o `NfsAzureFile` desde `container_app` o `container_app_job`
- cuando necesitas compartir ficheros entre varias revisiones o procesos

## Entradas relevantes

- `container_app_environment_id`
- `account_name`
- `share_name`
- `access_key`
- `access_mode`
- `nfs_server_url`

## Dependencias habituales

- un storage account existente
- un file share existente

## Restricciones y notas

- este módulo no crea la cuenta ni el share; sólo los registra dentro del entorno
- `access_mode` admite `ReadOnly` y `ReadWrite`
- si usas NFS, `nfs_server_url` debe apuntar al servidor correcto del share

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_container_app_environment_storage`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_storage
