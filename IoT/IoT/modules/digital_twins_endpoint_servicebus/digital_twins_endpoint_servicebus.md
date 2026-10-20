# Módulo Terraform: Digital Twins Endpoint Service Bus

Despliega un endpoint de tipo `Service Bus` para una `Digital Twins Instance`.

## Recursos Terraform

- `azurerm_digital_twins_endpoint_servicebus`

## Dependencias habituales

- `digital_twins_id`
- primary y secondary connection string de Service Bus, normalmente externas a este stack

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_digital_twins_endpoint_servicebus`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_endpoint_servicebus
