# Módulo Terraform: Machine Learning Inference Cluster

Adjunta un AKS existente a AML como `Inference Cluster`.

## Recursos Terraform

- `azurerm_machine_learning_inference_cluster`

## Restricciones y notas

- este recurso no crea AKS; solo lo adjunta al workspace
- si usas `ssl`, debes elegir un solo enfoque de configuración

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_inference_cluster`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster
