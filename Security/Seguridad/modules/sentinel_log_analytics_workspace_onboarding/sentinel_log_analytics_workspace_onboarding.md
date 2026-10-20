# Módulo Terraform: Sentinel Log Analytics Workspace Onboarding

Activa `Microsoft Sentinel` sobre un `Log Analytics Workspace`.

## Recursos Terraform

- `azurerm_sentinel_log_analytics_workspace_onboarding`

## Entradas relevantes

- `workspace_id`
- `customer_managed_key_enabled`

## Restricciones y notas

- el workspace debe existir previamente
- este recurso habilita Microsoft Sentinel sobre el workspace indicado
- `customer_managed_key_enabled` es opcional y depende de la estrategia de cifrado del entorno
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_sentinel_log_analytics_workspace_onboarding`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_log_analytics_workspace_onboarding
