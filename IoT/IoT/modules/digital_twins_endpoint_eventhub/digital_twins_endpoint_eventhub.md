# Módulo Terraform: Digital Twins Endpoint Event Hub

Despliega un endpoint de tipo `Event Hub` para una `Digital Twins Instance`.

## Recursos Terraform

- `azurerm_digital_twins_endpoint_eventhub`

## Dependencias habituales

- `digital_twins_id`
- primary y secondary connection string de Event Hub, normalmente externas a este stack

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_digital_twins_endpoint_eventhub`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_endpoint_eventhub
