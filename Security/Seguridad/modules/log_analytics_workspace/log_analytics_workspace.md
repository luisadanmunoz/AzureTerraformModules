# Módulo Terraform: Log Analytics Workspace

Despliega un `Log Analytics Workspace` como base de ingesta y analítica para servicios de seguridad.

## Recursos Terraform

- `azurerm_log_analytics_workspace`

## Entradas relevantes

- `log_analytics_workspace_name`
- `resource_group_name`
- `location`
- `sku`
- `retention_in_days`
- `identity`

## Restricciones y notas

- este workspace suele ser dependencia de Microsoft Defender y Microsoft Sentinel
- `identity` es opcional y permite escenarios con identidades administradas
- la retención, cuota y capacidades de red deben alinearse con el modelo operativo del SOC
- SKU habitual: `PerGB2018`

## Fuente de referencia

- Terraform Registry: `azurerm_log_analytics_workspace`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
