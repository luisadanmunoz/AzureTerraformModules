# Módulo Terraform: Network Watcher

Despliega un `Network Watcher` en una región de Azure.

## Cuándo usarlo

- para habilitar diagnóstico de red, `Connection Monitor`, `IP Flow Verify` o `NSG Flow Logs`
- como base de observabilidad de red por región

## Entradas relevantes

- `network_watcher_name`: nombre del recurso
- `location`: región donde operará el watcher
- `resource_group_name`: grupo de recursos donde residirá

## Restricciones y notas

- Microsoft suele usar uno por región y suscripción
- conviene no duplicarlo innecesariamente en la misma región
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_network_watcher`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher
