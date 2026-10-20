# Módulo Terraform: Diagnostic Settings

Despliega una **configuración de diagnósticos** para enviar logs y métricas de un recurso a Azure Monitor.

## Recurso Terraform

- `azurerm_monitor_diagnostic_setting`

## SKU

- no aplica en el recurso
- el coste real depende del destino, por ejemplo Log Analytics o Storage Account

## Destinos soportados

- Log Analytics Workspace
- Storage Account
- Event Hub

## Entradas relevantes

- `diagnostic_settings_name`
- `target_resource_id`
- `log_analytics_workspace_id`
- `log_analytics_destination_type`
- `storage_account_id`
- `eventhub_authorization_rule_id`
- `log_categories`
- `metric_categories`

## Restricciones y notas

- al menos un destino debe estar informado
- las categorías de logs y métricas dependen del recurso objetivo
- este módulo ya usa `enabled_metric`, alineado con `azurerm` 4.x y 5.x
- si usas Log Analytics puedes controlar `log_analytics_destination_type` cuando el recurso lo requiera

## Fuente de referencia

- Terraform Registry: `azurerm_monitor_diagnostic_setting`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting
