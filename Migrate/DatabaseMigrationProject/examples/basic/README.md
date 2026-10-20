<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_dms"></a> [dms](#module\_dms) | ../../../DatabaseMigrationService | n/a |
| <a name="module_project_postgres"></a> [project\_postgres](#module\_project\_postgres) | ../../ | n/a |
| <a name="module_project_sql"></a> [project\_sql](#module\_project\_sql) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.dms](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_postgres_project_id"></a> [postgres\_project\_id](#output\_postgres\_project\_id) | The ID of the PostgreSQL migration project. |
| <a name="output_sql_project_id"></a> [sql\_project\_id](#output\_sql\_project\_id) | The ID of the SQL migration project. |
<!-- END_TF_DOCS -->