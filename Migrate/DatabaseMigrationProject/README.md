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
