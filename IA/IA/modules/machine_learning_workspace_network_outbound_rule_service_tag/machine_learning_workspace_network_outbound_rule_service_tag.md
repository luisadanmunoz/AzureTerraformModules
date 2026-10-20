# Módulo Terraform: Machine Learning Workspace Network Outbound Rule Service Tag

Crea una regla de salida por `Service Tag` para un workspace de Azure Machine Learning.

## Recursos Terraform

- `azurerm_machine_learning_workspace_network_outbound_rule_service_tag`

## Cuándo usarlo

- cuando el workspace usa `managed_network` con salidas aprobadas
- cuando necesitas permitir salida a un servicio Azure completo en lugar de un FQDN puntual

## Entradas relevantes

- `workspace_id`
- `service_tag`
- `protocol`
- `port_ranges`

## Dependencias habituales

- un `machine_learning_workspace` existente con red administrada

## Restricciones y notas

- `protocol` solo acepta `*`, `TCP`, `UDP` o `ICMP`
- `port_ranges` acepta un puerto, un rango o una lista separada por comas

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_machine_learning_workspace_network_outbound_rule_service_tag`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace_network_outbound_rule_service_tag
