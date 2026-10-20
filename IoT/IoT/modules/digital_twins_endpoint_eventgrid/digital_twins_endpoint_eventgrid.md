# Módulo Terraform: Digital Twins Endpoint Event Grid

Despliega un endpoint de tipo `Event Grid` para una `Digital Twins Instance`.

## Recursos Terraform

- `azurerm_digital_twins_endpoint_eventgrid`

## Dependencias habituales

- `digital_twins_id`
- topic y keys de Event Grid, normalmente externos a este stack

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_digital_twins_endpoint_eventgrid`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_endpoint_eventgrid
