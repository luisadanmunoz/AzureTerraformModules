# Módulo Terraform: Machine Learning Synapse Spark

Enlaza un `Synapse Spark Pool` existente a un workspace de Azure Machine Learning.

## Recursos Terraform

- `azurerm_machine_learning_synapse_spark`

## Cuándo usarlo

- cuando necesitas usar Spark de Synapse desde AML
- cuando quieres mantener Synapse fuera de este stack pero conectarlo por id

## Entradas relevantes

- `machine_learning_workspace_id`
- `synapse_spark_pool_id`
- `location`
- `identity`

## Dependencias habituales

- un `machine_learning_workspace` existente
- un `synapse_spark_pool_id` existente, normalmente externo a este stack

## Restricciones y notas

- este recurso enlaza Synapse; no crea el workspace de Synapse ni el Spark Pool
- si `identity.type` es `UserAssigned`, debes aportar `identity_ids`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_synapse_spark`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_synapse_spark
