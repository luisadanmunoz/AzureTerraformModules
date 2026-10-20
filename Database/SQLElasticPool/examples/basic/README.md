<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_elastic_pool"></a> [elastic\_pool](#module\_elastic\_pool) | ../../ | n/a |
| <a name="module_sql_server"></a> [sql\_server](#module\_sql\_server) | ../../../SQLServer | n/a |
| <a name="module_tenant_databases"></a> [tenant\_databases](#module\_tenant\_databases) | ../../../SQLDatabase | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_connection_template"></a> [connection\_template](#output\_connection\_template) | n/a |
| <a name="output_elastic_pool_id"></a> [elastic\_pool\_id](#output\_elastic\_pool\_id) | n/a |
| <a name="output_elastic_pool_name"></a> [elastic\_pool\_name](#output\_elastic\_pool\_name) | n/a |
| <a name="output_tenant_database_ids"></a> [tenant\_database\_ids](#output\_tenant\_database\_ids) | n/a |
<!-- END_TF_DOCS -->