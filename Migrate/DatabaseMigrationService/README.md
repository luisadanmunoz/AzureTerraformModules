# Azure Database Migration Service

Terraform module for creating Azure Database Migration Service (DMS) resources.

## Features

- Database migration service for online and offline migrations
- Configurable SKU (Standard and Premium)
- VNet integration via subnet
- Conditional resource creation

## Usage

```hcl
module "dms" {
  source = "path/to/Migrate/DatabaseMigrationService"

  name                = "dms-migration-prod"
  resource_group_name = azurerm_resource_group.migrate.name
  location            = "eastus"
  subnet_id           = azurerm_subnet.dms.id
  sku_name            = "Standard_1vCores"

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
| name | Service name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| subnet_id | Subnet ID for VNet integration | `string` | n/a | yes |
| sku_name | SKU name | `string` | `"Standard_1vCores"` | no |
| create | Whether to create | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The service ID |
| name | The service name |
