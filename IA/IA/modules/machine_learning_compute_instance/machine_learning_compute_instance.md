# Módulo Terraform: Machine Learning Compute Instance

Despliega una `Compute Instance` de AML para uso interactivo o personal.

## Recursos Terraform

- `azurerm_machine_learning_compute_instance`

## Restricciones y notas

- `subnet_resource_id` pasa a ser importante cuando deshabilitas la IP pública
- `ssh.public_key` es el camino recomendado para acceso seguro

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_compute_instance`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_instance
