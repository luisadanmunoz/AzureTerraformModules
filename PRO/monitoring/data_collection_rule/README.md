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
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_monitor_data_collection_rule.dcr_vminsight](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule) | resource |
| [azurerm_monitor_data_collection_rule.dcr_win](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_dcr_name"></a> [dcr\_name](#input\_dcr\_name) | value of the dcr name tag | `string` | n/a | yes |
| <a name="input_dcr_vminsight_name"></a> [dcr\_vminsight\_name](#input\_dcr\_vminsight\_name) | value of the dcr vminsight name tag | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value of the location tag | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value of the resource group name tag | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value of the tags tag | `map(any)` | n/a | yes |
| <a name="input_workspace_resource_id"></a> [workspace\_resource\_id](#input\_workspace\_resource\_id) | value of the workspace resource id tag | `string` | n/a | yes |
| <a name="input_workspace_resource_name"></a> [workspace\_resource\_name](#input\_workspace\_resource\_name) | value of the workspace resource name tag | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id_dcr_win"></a> [id\_dcr\_win](#output\_id\_dcr\_win) | value of the id tag |
| <a name="output_id_vminsight"></a> [id\_vminsight](#output\_id\_vminsight) | value of the id tag |
| <a name="output_name_dcr_win"></a> [name\_dcr\_win](#output\_name\_dcr\_win) | value of the name tag |
| <a name="output_name_vminsight"></a> [name\_vminsight](#output\_name\_vminsight) | value of the name tag |
<!-- END_TF_DOCS -->