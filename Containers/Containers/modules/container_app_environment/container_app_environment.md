# Módulo Terraform: Container App Environment

Despliega un `Container App Environment` como base compartida para apps, jobs, Dapr, certificados y DNS de Azure Container Apps.

## Recursos Terraform

- `azurerm_container_app_environment`

## Cuándo usarlo

- cuando quieres agrupar varias `container_app` y `container_app_job` en un mismo entorno gestionado
- cuando necesitas centralizar logs, workload profiles, certificados o sufijos DNS

## Entradas relevantes

- `container_app_environment_name`
- `resource_group_name`
- `location`
- `logs_destination`
- `log_analytics_workspace_id`
- `infrastructure_subnet_id`
- `internal_load_balancer_enabled`
- `workload_profile`
- `identity`

## Dependencias habituales

- `log_analytics_workspace_id` cuando `logs_destination = "log-analytics"`
- `infrastructure_subnet_id` cuando el entorno sea interno o con zone redundancy

## Restricciones y notas

- `logs_destination = "log-analytics"` exige `log_analytics_workspace_id`
- `logs_destination = "azure-monitor"` no admite `log_analytics_workspace_id`
- `internal_load_balancer_enabled` y `zone_redundancy_enabled` requieren `infrastructure_subnet_id`
- si defines `infrastructure_resource_group_name`, AzureRM espera también `workload_profile`

## Outputs principales

- `id`
- `name`
- `default_domain`
- `static_ip_address`
- `custom_domain_verification_id`

## Fuente de referencia

- Terraform Registry: `azurerm_container_app_environment`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment
