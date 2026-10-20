# Terraform Module: Data Collection Rule

Este módulo de Terraform crea reglas de recopilación de datos en Azure Monitor para la monitorización de métricas y eventos.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_monitor_data_collection_rule.dcr_win`: Regla de recopilación de datos para rendimiento y eventos de Windows.
- `azurerm_monitor_data_collection_rule.dcr_vminsight`: Regla de recopilación de datos para VM Insights y Service Map.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                   | Tipo        | Descripción                                                  | Por defecto |
|--------------------------|------------|--------------------------------------------------------------|------------|
| `dcr_name`               | `string`   | Nombre de la regla de recopilación de datos para Windows.   | -          |
| `resource_group_name`    | `string`   | Nombre del grupo de recursos donde se creará la regla.      | -          |
| `location`               | `string`   | Ubicación de la regla de recopilación de datos.             | -          |
| `workspace_resource_id`  | `string`   | ID del recurso del workspace de Log Analytics.              | -          |
| `workspace_resource_name`| `string`   | Nombre del workspace de Log Analytics.                      | -          |
| `dcr_vminsight_name`     | `string`   | Nombre de la regla de recopilación de datos para VM Insights. | -          |
| `tags`                   | `map(any)` | Etiquetas opcionales para la regla de recopilación de datos. | `{}`       |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre           | Descripción                                      |
|-----------------|--------------------------------------------------|
| `id_dcr_win`   | ID de la regla de recopilación de datos de Windows. |
| `id_vminsight` | ID de la regla de recopilación de datos de VM Insights. |
| `name_dcr_win` | Nombre de la regla de recopilación de datos de Windows. |
| `name_vminsight` | Nombre de la regla de recopilación de datos de VM Insights. |

## Uso

Ejemplo de uso del módulo:

```hcl
module "data_collection_rule" {
  source                  = "./ruta/al/modulo"
  dcr_name                = "DCR-Windows"
  resource_group_name     = "mi-grupo-de-recursos"
  location                = "East US"
  workspace_resource_id   = "/subscriptions/sub-id/resourceGroups/rg-name/providers/Microsoft.OperationalInsights/workspaces/workspace-name"
  workspace_resource_name = "workspace-name"
  dcr_vminsight_name      = "DCR-VMInsights"
  tags                    = { env = "prod" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de reglas de recopilación de datos en Azure Monitor.