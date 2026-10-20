# Módulo Terraform: Machine Learning Workspace Network Outbound Rule FQDN

Crea una regla de salida por `FQDN` para un workspace de Azure Machine Learning.

## Recursos Terraform

- `azurerm_machine_learning_workspace_network_outbound_rule_fqdn`

## Cuándo usarlo

- cuando el workspace usa `managed_network` con salidas aprobadas
- cuando necesitas permitir tráfico saliente hacia un dominio concreto

## Entradas relevantes

- `workspace_id`
- `destination_fqdn`

## Dependencias habituales

- un `machine_learning_workspace` existente con red administrada

## Restricciones y notas

- este recurso no aplica a workspaces sin red administrada
- la salida queda acotada al FQDN indicado

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_workspace_network_outbound_rule_fqdn`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace_network_outbound_rule_fqdn
