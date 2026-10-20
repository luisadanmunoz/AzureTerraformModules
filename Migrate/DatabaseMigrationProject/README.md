# Azure Database Migration Project

Terraform module for creating Azure Database Migration Project resources.

## Features

- Migration project for tracking database migrations
- Support for multiple source platforms (SQL, MySQL, PostgreSQL, MongoDB)
- Support for multiple target platforms (Azure SQL, Azure MySQL, Azure PostgreSQL)
- Integration with Database Migration Service
- Conditional resource creation

## Usage

```hcl
module "migration_project" {
  source = "path/to/Migrate/DatabaseMigrationProject"

  name                = "migrate-sql-to-azure"
  resource_group_name = azurerm_resource_group.migrate.name
  location            = "eastus"
  service_name        = module.dms.name
  source_platform     = "SQL"
  target_platform     = "SQLDB"

  tags = {
    Environment = "Production"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Project name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| service_name | DMS name | `string` | n/a | yes |
| source_platform | Source platform | `string` | n/a | yes |
| target_platform | Target platform | `string` | n/a | yes |
| create | Whether to create | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The project ID |
| name | The project name |

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

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_database_migration_project.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/database_migration_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Database Migration Project. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Database Migration Project. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the Database Migration Service. | `string` | n/a | yes |
| <a name="input_source_platform"></a> [source\_platform](#input\_source\_platform) | The source platform. Possible values: SQL, MySQL, PostgreSql, MongoDb, Unknown. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |
| <a name="input_target_platform"></a> [target\_platform](#input\_target\_platform) | The target platform. Possible values: SQLDB, AzureDbForMySql, AzureDbForPostgreSql, MongoDb, Unknown. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Database Migration Project. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Database Migration Project. |
<!-- END_TF_DOCS -->