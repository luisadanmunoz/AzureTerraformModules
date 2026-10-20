# Módulo Terraform: Machine Learning Workspace

Despliega un `Machine Learning Workspace` como base de Azure Machine Learning.

## Recursos Terraform

- `azurerm_machine_learning_workspace`

## Entradas relevantes

- `application_insights_id`
- `key_vault_id`
- `storage_account_id`
- `identity`
- `encryption`
- `managed_network`

## Restricciones y notas

- `application_insights_id`, `key_vault_id` y `storage_account_id` son obligatorios
- `feature_store` es obligatorio cuando `kind = "FeatureStore"`
- `service_side_encryption_enabled` exige también el bloque `encryption`

## Outputs principales

- `id`
- `name`
- `workspace_id`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_workspace`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace
