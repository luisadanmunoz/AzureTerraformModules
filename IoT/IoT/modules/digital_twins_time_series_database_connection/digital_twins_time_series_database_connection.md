# Módulo Terraform: Digital Twins Time Series Database Connection

Despliega una `Time Series Database Connection` para una `Digital Twins Instance`.

## Recursos Terraform

- `azurerm_digital_twins_time_series_database_connection`

## Dependencias habituales

- `digital_twins_id`
- ids y uris de Event Hub y Kusto, normalmente externos a este stack

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_digital_twins_time_series_database_connection`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_time_series_database_connection
