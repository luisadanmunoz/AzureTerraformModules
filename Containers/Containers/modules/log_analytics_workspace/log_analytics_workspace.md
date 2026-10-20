# Módulo Terraform: Log Analytics Workspace

Despliega un `Log Analytics Workspace` como dependencia base de observabilidad para Azure Container Apps.

## Recursos Terraform

- `azurerm_log_analytics_workspace`

## Cuándo usarlo

- cuando quieres usar `logs_destination = "log-analytics"` en `container_app_environment`
- cuando quieres dejar listo el entorno para diagnósticos, métricas y troubleshooting

## Entradas relevantes

- `log_analytics_workspace_name`
- `resource_group_name`
- `location`
- `sku`
- `retention_in_days`
- `daily_quota_gb`
- `identity`

## Restricciones y notas

- el SKU habitual para Container Apps es `PerGB2018`
- si usas `CapacityReservation`, Azure impone compromisos de capacidad y cambios más restrictivos
- este módulo no crea Data Collection Rules; solo el workspace

## Outputs principales

- `id`
- `name`
- `workspace_id`

## Fuente de referencia

- Terraform Registry: `azurerm_log_analytics_workspace`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
