# Módulo Terraform: Machine Learning Workspace Network Outbound Rule Private Endpoint

Crea una regla de salida por `Private Endpoint` para un workspace de Azure Machine Learning.

## Recursos Terraform

- `azurerm_machine_learning_workspace_network_outbound_rule_private_endpoint`

## Cuándo usarlo

- cuando el workspace usa `managed_network` con salidas aprobadas
- cuando necesitas llegar por private endpoint a Storage, Key Vault, Redis u otro workspace AML

## Entradas relevantes

- `workspace_id`
- `service_resource_id`
- `sub_resource_target`
- `spark_enabled`

## Dependencias habituales

- un `machine_learning_workspace` existente con red administrada
- el recurso de destino ya creado

## Restricciones y notas

- `sub_resource_target` debe encajar con el tipo de servicio de destino
- `spark_enabled` añade el private endpoint adicional para cargas Spark cuando aplica

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_workspace_network_outbound_rule_private_endpoint`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace_network_outbound_rule_private_endpoint
