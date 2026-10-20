# Módulo Terraform: Machine Learning Datastore Blob Storage

Registra un `Blob Storage DataStore` dentro de un workspace de Azure Machine Learning.

## Recursos Terraform

- `azurerm_machine_learning_datastore_blobstorage`

## Cuándo usarlo

- cuando necesitas registrar un contenedor Blob como datastore en AML
- cuando quieres marcar un datastore como predeterminado del workspace

## Entradas relevantes

- `workspace_id`
- `storage_container_id`
- `account_key`
- `shared_access_signature`
- `service_data_auth_identity`

## Dependencias habituales

- un `machine_learning_workspace` existente
- un `storage_container_id` ya creado, normalmente en `Almacenamiento`

## Restricciones y notas

- `account_key` y `shared_access_signature` son excluyentes
- si `service_data_auth_identity` es `None` o no se informa, debes aportar `account_key` o `shared_access_signature`
- `is_default` solo puede pasarse a `true` sobre actualización

## Outputs principales

- `id`
- `name`
- `is_default`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_datastore_blobstorage`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_datastore_blobstorage
