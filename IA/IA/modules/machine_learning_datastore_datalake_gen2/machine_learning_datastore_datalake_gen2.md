# Módulo Terraform: Machine Learning Datastore Data Lake Gen2

Registra un `Data Lake Gen2 DataStore` dentro de un workspace de Azure Machine Learning.

## Recursos Terraform

- `azurerm_machine_learning_datastore_datalake_gen2`

## Cuándo usarlo

- cuando necesitas registrar un contenedor ADLS Gen2 como datastore en AML
- cuando quieres usar identidad del workspace o un service principal para acceder al lago

## Entradas relevantes

- `workspace_id`
- `storage_container_id`
- `service_data_identity`
- `tenant_id`
- `client_id`
- `client_secret`

## Dependencias habituales

- un `machine_learning_workspace` existente
- un `storage_container_id` ya creado, normalmente en `Almacenamiento`

## Restricciones y notas

- `service_data_identity` puede usar `None`, `WorkspaceSystemAssignedIdentity` o `WorkspaceUserAssignedIdentity`
- si decides autenticar con service principal, conviene aportar el trio `tenant_id`, `client_id` y `client_secret`

## Outputs principales

- `id`
- `name`
- `is_default`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_datastore_datalake_gen2`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_datastore_datalake_gen2
