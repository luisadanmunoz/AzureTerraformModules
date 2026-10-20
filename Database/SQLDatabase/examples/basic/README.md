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
| <a name="module_dev_database"></a> [dev\_database](#module\_dev\_database) | ../../ | n/a |
| <a name="module_production_database"></a> [production\_database](#module\_production\_database) | ../../ | n/a |
| <a name="module_sql_server"></a> [sql\_server](#module\_sql\_server) | ../../../SQLServer | n/a |

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
| <a name="output_connection_string_template"></a> [connection\_string\_template](#output\_connection\_string\_template) | Connection string template (add database name) |
| <a name="output_dev_database_id"></a> [dev\_database\_id](#output\_dev\_database\_id) | n/a |
| <a name="output_production_database_id"></a> [production\_database\_id](#output\_production\_database\_id) | n/a |
| <a name="output_production_database_name"></a> [production\_database\_name](#output\_production\_database\_name) | n/a |
<!-- END_TF_DOCS -->