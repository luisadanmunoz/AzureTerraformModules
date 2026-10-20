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
| <a name="module_cosmosdb"></a> [cosmosdb](#module\_cosmosdb) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cosmosdb_endpoint"></a> [cosmosdb\_endpoint](#output\_cosmosdb\_endpoint) | The endpoint of the Cosmos DB Account |
| <a name="output_cosmosdb_id"></a> [cosmosdb\_id](#output\_cosmosdb\_id) | The ID of the Cosmos DB Account |
| <a name="output_cosmosdb_name"></a> [cosmosdb\_name](#output\_cosmosdb\_name) | The name of the Cosmos DB Account |
| <a name="output_cosmosdb_primary_key"></a> [cosmosdb\_primary\_key](#output\_cosmosdb\_primary\_key) | The primary key of the Cosmos DB Account |
<!-- END_TF_DOCS -->