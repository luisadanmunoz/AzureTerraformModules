# Módulo Terraform: Machine Learning Datastore Fileshare

Registra un `File Share DataStore` dentro de un workspace de Azure Machine Learning.

## Recursos Terraform

- `azurerm_machine_learning_datastore_fileshare`

## Cuándo usarlo

- cuando necesitas registrar un Azure File Share como datastore en AML
- cuando quieres consumir datasets o artefactos sobre SMB desde el workspace

## Entradas relevantes

- `workspace_id`
- `storage_fileshare_id`
- `account_key`
- `shared_access_signature`
- `service_data_identity`

## Dependencias habituales

- un `machine_learning_workspace` existente
- un `storage_fileshare_id` ya creado, normalmente en `Almacenamiento`

## Restricciones y notas

- `account_key` y `shared_access_signature` son excluyentes
- `service_data_identity` permite usar la identidad del workspace en lugar de credenciales explícitas

## Outputs principales

- `id`
- `name`
- `is_default`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_datastore_fileshare`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_datastore_fileshare
