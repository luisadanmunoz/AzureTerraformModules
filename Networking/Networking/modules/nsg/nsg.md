# Módulo Terraform: Network Security Group

Despliega un `Network Security Group` de Azure con reglas inline.

## Cuándo usarlo

- cuando quieres controlar tráfico entrante y saliente a nivel de subnet o NIC
- cuando necesitas una capa base de segmentación de red

## Entradas relevantes

- `nsg_name`: nombre del NSG
- `location`: región del recurso
- `security_rules`: reglas inline con prioridad, dirección, protocolo y prefijos o rangos

## Restricciones y notas

- en este módulo las reglas se gestionan inline dentro del recurso `azurerm_network_security_group`
- no conviene mezclar reglas inline con recursos externos `azurerm_network_security_rule` sobre el mismo NSG
- la prioridad de cada regla debe ser única dentro del NSG
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_network_security_group`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
