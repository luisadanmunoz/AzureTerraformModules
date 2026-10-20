# Módulo Terraform: Machine Learning Compute Cluster

Despliega un `Compute Cluster` de AML para entrenamiento o procesos escalables.

## Recursos Terraform

- `azurerm_machine_learning_compute_cluster`

## Entradas relevantes

- `machine_learning_workspace_id`
- `vm_priority`
- `vm_size`
- `scale_settings`
- `subnet_resource_id`

## Restricciones y notas

- `scale_settings` es obligatorio
- si defines `ssh`, debes indicar `admin_password` o `key_value`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_compute_cluster`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_cluster
