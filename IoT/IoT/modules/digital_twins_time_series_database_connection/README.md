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
| [azurerm_digital_twins_time_series_database_connection.digital_twins_time_series_database_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_time_series_database_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_digital_twins_id"></a> [digital\_twins\_id](#input\_digital\_twins\_id) | value to set the digital twins id | `string` | n/a | yes |
| <a name="input_digital_twins_time_series_database_connection_name"></a> [digital\_twins\_time\_series\_database\_connection\_name](#input\_digital\_twins\_time\_series\_database\_connection\_name) | value to set the digital twins time series database connection name | `string` | n/a | yes |
| <a name="input_eventhub_consumer_group_name"></a> [eventhub\_consumer\_group\_name](#input\_eventhub\_consumer\_group\_name) | value to set the eventhub consumer group name | `string` | `null` | no |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | value to set the eventhub name | `string` | n/a | yes |
| <a name="input_eventhub_namespace_endpoint_uri"></a> [eventhub\_namespace\_endpoint\_uri](#input\_eventhub\_namespace\_endpoint\_uri) | value to set the eventhub namespace endpoint uri | `string` | n/a | yes |
| <a name="input_eventhub_namespace_id"></a> [eventhub\_namespace\_id](#input\_eventhub\_namespace\_id) | value to set the eventhub namespace id | `string` | n/a | yes |
| <a name="input_kusto_cluster_id"></a> [kusto\_cluster\_id](#input\_kusto\_cluster\_id) | value to set the kusto cluster id | `string` | n/a | yes |
| <a name="input_kusto_cluster_uri"></a> [kusto\_cluster\_uri](#input\_kusto\_cluster\_uri) | value to set the kusto cluster uri | `string` | n/a | yes |
| <a name="input_kusto_database_name"></a> [kusto\_database\_name](#input\_kusto\_database\_name) | value to set the kusto database name | `string` | n/a | yes |
| <a name="input_kusto_table_name"></a> [kusto\_table\_name](#input\_kusto\_table\_name) | value to set the kusto table name | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the digital twins time series database connection id |
| <a name="output_name"></a> [name](#output\_name) | value of the digital twins time series database connection name |
<!-- END_TF_DOCS -->