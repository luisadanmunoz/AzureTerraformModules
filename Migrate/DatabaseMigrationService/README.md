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
| [azurerm_database_migration_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/database_migration_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Database Migration Service. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Database Migration Service. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name. Possible values: Standard\_1vCores, Standard\_2vCores, Standard\_4vCores, Premium\_4vCores. | `string` | `"Standard_1vCores"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet where the DMS instance will be deployed. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Database Migration Service. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Database Migration Service. |
<!-- END_TF_DOCS -->